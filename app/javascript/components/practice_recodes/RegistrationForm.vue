<template>
  <span class="has-text-left">
    <div class="field">
      <b-field label="日時">
        <div class="control">
          <b-datepicker name="date"
            v-validate="'required|date_format:YYYY/MM/DD'"
            data-vv-as="日付"
            v-model="date"
            :events="events"
            :indicators="'bars'"
            placeholder="クリックして下さい"
            icon-pack="far"
            icon="calendar-alt"
            :month-names="months">
          </b-datepicker>
        </div>
      </b-field>
      <li>
        <a @click="isLatelyPlansModalActive = true">
          最近の練習予定から日付を選択する
        </a>
      </li>
      <p class="help is-danger" v-show="errors.has('date')">
        {{ errors.first('date') }}
      </p>
    </div>

    <div class="field">
      <label class="label">コース</label>
      <div class="control">
        <select name="cource"
          v-model="cource"
          v-validate="'required'"
          data-vv-as="コース"
        >
          <option value="">選択して下さい</option>
          <option v-for="favoriteCourse in favoriteCourses" :value="favoriteCourse.off_road_circuit_id">
            {{ favoriteCourse.name }}
          </option>
        </select>
        <p class="help is-danger" v-show="errors.has('cource')">
          {{ errors.first('cource') }}
        </p>
      </div>
    </div>

    <hr>

    <div class="field">
      <label class="label">走行時間</label>
      <div class="control">
        <select name="duration_hour"
          v-model="durationHour"
          v-validate="'max_value:23'"
          data-vv-as="走行時間(時)"
        >
          <option v-for="hour in hours" :value="hour">
            {{ hour }}
          </option>
        </select>
        時間
        <p class="help is-danger" v-show="errors.has('duration_hour')">
          {{ errors.first('duration_hour') }}
        </p>

        <div class="control">
          <select name="duration_minute"
            v-model="durationMinute"
            v-validate="'max_value:59'"
            data-vv-as="走行時間(分)"
          >
            <option v-for="minute in minutes" :value="minute">
              {{ minute }}
            </option>
          </select>
          分
          <p class="help is-danger" v-show="errors.has('duration_minute')">
            {{ errors.first('duration_minute') }}
          </p>
        </div>
      </div>
    </div>

    <div class="field">
      <label class="label">メモ</label>
      <div class="control">
        <textarea class="textarea" name="comment" rows="2" placeholder="タイムやマシン、コース状況など"
          v-model="comment"
          v-validate="'max:255'"
          data-vv-as="メモ"
        />
        <p class="help is-danger" v-show="errors.has('comment')">
          {{ errors.first('comment') }}
        </p>
      </div>
    </div>

    <div class="field">
      <div class="control">
        <button @click="registerPractice()" class="button is-block is-info is-fullwidth">記録する</button>
      </div>
    </div>

    <b-modal :active.sync="isValidateErrorModalActive">
      <article class="message is-danger">
        <div class="message-body">
          <p>登録に失敗しました (´・ω・｀)</p>
          {{ serverErrors }}
        </div>
      </article>
    </b-modal>

    <b-modal :active.sync="isLatelyPlansModalActive">
      <LatelyPlans :userId="userId" v-on:selected="inputDate" />
    </b-modal>
  </span>
</template>

<script>
import axios from 'axios'
import moment from 'moment'
import LatelyPlans from '../plans/LatelyPlans.vue'

export default {
  components: { LatelyPlans },
  props: ['userId'],
  data() {
    return {
      date: null,
      favoriteCourses: [],
      cource: "",
      months: [...Array(12).keys()].map(i => `${++i}月`),
      durationHour: 0,
      hours: [...Array(24).keys()],
      durationMinute: 0,
      minutes: [...Array(60).keys()],
      comment: "",
      isLatelyPlansModalActive: false,
      isValidateErrorModalActive: false,
      serverErrors: {},
      events: []
    }
  },
  mounted: async function() {
    const res = await axios.get(`/api/users/${this.userId}/favorite_courses`)
    if (res.status !== 200) {
      process.exit()
    }
    this.favoriteCourses = res.data.favorite_courses

    // １ヶ月前〜1ヶ月後までのplanを取得
    const from = moment().add(-1, 'months').format("YYYY-MM-DD")
    const to = moment().add(+1, 'months').format("YYYY-MM-DD")
    const plans = await axios.get(`/api/plans/?user_id=${this.userId}&date[]=${from}&date[]=${to}`)
    let events = []
    plans.data.plans.forEach(function(value) {
      events.push(
        {
          date: moment(value.date).toDate(),
          type: 'is-info'
        }
      )
    })
    this.events = events
  },
  methods: {
    async registerPractice() {
      const validRes = await this.$validator.validateAll()
      if (!validRes) {
        return
      }

      const res = await axios.post(
        `/api/users/${this.userId}/practice_recodes`,
        {
          practice_date: moment(this.date).format('YYYY-MM-DD'),
          off_road_circuit_id: this.cource,
          duration_hour: this.durationHour,
          duration_minute: this.durationMinute,
          comment: this.comment
        }
      )
      if (res.status === 201) {
        this.$toast.open({
          message: '登録しました!',
          type: 'is-success'
        })
        this.$root.eventBus.$emit('refresh-charts')
      } else {
        if (res.data['practice_date']) {
          this.serverErrors = `${moment(this.date).format('YYYY-MM-DD')}の記録${res.data['practice_date'][0]}別の日付で登録して下さい。`
        } else {
          this.serverErrors = "お手数ですが、もう一度お願いします。"
        }
        this.isValidateErrorModalActive = true
        return
      }
    },
    inputDate(date) {
      this.date = moment(date).toDate()
      this.isLatelyPlansModalActive = false
    }
  }
}
</script>

<style lang="scss">
@import "../../mixin/buefy.scss";
</style>
