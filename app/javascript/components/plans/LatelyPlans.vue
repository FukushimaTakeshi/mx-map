<template>
  <div class="modal-card">
    <header class="modal-card-head">
      <p class="modal-card-title">最近の練習予定(過去3ヶ月)</p>
    </header>
    <section class="modal-card-body">
      <div class="columns is-mobile is-multiline is-centered">

        <div v-for="latelyPlan in latelyPlans" @click="selectDate(latelyPlan['date'])" class="column is-four-fifths post">
          <span class="media">
            <div class="media-left">
              <h4>{{ latelyPlan['date'] }}</h4>
            </div>
            <div class="media-content">
              <h4>{{ latelyPlan['off_road_circuit_name'] }}</h4>
            </div>
            <div class="medis-right">
              <span v-if="isRegistered(latelyPlan['date'])" class="tag is-light">登録済み</span>
              <span v-else class="tag is-primary">未登録</span>
            </div>
          </span>
        </div>
      </div>
    </section>
    <footer class="modal-card-foot">
      <button class="button" @click="$parent.close()">閉じる</button>
    </footer>
  </div>
</template>

<script>
import axios from 'axios'
import moment from 'moment'

export default {
  props: [
    'userId'
  ],
  data() {
    return {
      latelyPlans: [],
      practiceRecodes: []
    }
  },
  mounted: async function() {
    const from = moment().add(-3, 'months').format("YYYY-MM-DD")
    const to = moment().format("YYYY-MM-DD")
    const plans = await axios.get(`/api/plans/?user_id=${this.userId}&date[]=${from}&date[]=${to}&sort=DESC`)
    if (plans.status !== 200) {
      process.exit()
    }
    this.latelyPlans = plans.data.plans

    const practiceRecodes = await axios.get(`/api/users/${this.userId}/practice_recodes/?date[]=${from}&date[]=${to}&sort=DESC`)
    if (practiceRecodes.status !== 200) {
      return false
    }
    this.practiceRecodes = practiceRecodes.data
  },
  methods: {
    selectDate: function(date) {
      this.$emit('selected', date)
    },
    isRegistered: function(date) {
      const isRegistered = this.practiceRecodes.find((practiceRecode) =>{
        return (practiceRecode['practice_date'] === date)
      })
      if (isRegistered) { return true }
    }
  }
}
</script>
<style>
.modal-card-body {
  max-height: 300px;
}

div.post {
  cursor: pointer;
  border-bottom: 1px solid #E6EAEE;
}
div.post:last-child {
  border-bottom: none;
}
</style>
