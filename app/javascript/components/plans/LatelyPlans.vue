<template>
  <div class="modal-card">
    <header class="modal-card-head">
      <p class="modal-card-title">最近の練習予定(過去3ヶ月)</p>
    </header>
    <section class="modal-card-body is-paddingless">
      <div class="columns is-mobile is-multiline is-centered">

        <div v-for="latelyPlan in latelyPlans" class="column is-four-fifths post">
          <span class="media">
            <div class="media-left">
              <h4>{{ latelyPlan['date'] }}</h4>
            </div>
            <div class="media-content">
              <h4>ああああ</h4>
            </div>
            <div class="medis-right">
              <button @click="selectDate(latelyPlan['date'])" class="button is-small is-primary">選択する</button>
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
      latelyPlans: []
    }
  },
  mounted: async function() {
    const from = moment().add(-3, 'months').format("YYYY-MM-DD")
    const to = moment().format("YYYY-MM-DD")
    const res = await axios.get(`/api/plans/?user_id=${this.userId}&date[]=${from}&date[]=${to}`)
    if (res.status !== 200) {
      process.exit()
    }
    this.latelyPlans = res.data.plans
  },
  methods: {
    selectDate: function(date) {
      this.$emit('selected', date)
    }
  }
}
</script>
