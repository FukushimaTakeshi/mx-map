<template>
  <span>
    <div class="columns is-gapless is-multiline is-mobile">
      <div class="column is-half">
        <practice-bar-chart></practice-bar-chart>
      </div>

      <div class="column is-half">
        <practice-pie-chart></practice-pie-chart>
      </div>
    </div>

    <span class="columns is-mobile">
      <div class="column">
        <button @click="back()" class="button is-white">
          <span class="icon is-medium mdi-18px">
            <i class="fas fa-angle-left"></i>
          </span>
          <span>前月</span>
        </button>
      </div>
      <div class="column">
        <button @click="next()" class="button is-white">
          <span>翌月</span>
          <span class="icon is-medium mdi-18px">
            <i class="fas fa-angle-right"></i>
          </span>
        </button>
      </div>
    </span>
  </span>
</template>

<script>
import axios from 'axios'
import moment from 'moment'
import PracticeBarChart from './PracticeBarChart.vue'
import PracticePieChart from './PracticePieChart.vue'
import EventBus from '../../packs/users/form.js'

export default {
  components: {
    PracticeBarChart,
    PracticePieChart
  },
  props: [
    'userId'
  ],
  data() {
    return {
      currentDate: new Date()
    }
  },
  computed: {
    practiceRecodes() {
      return this.$store.state.practiceRecodes
    }
  },
  created() {
    this.updatePracticeRecodes().then(() => {
      this.fetchFullYearData()
      this.fetchMonthData()
      EventBus.$on('change-pie-chart', this.fetchMonthData)
    })
  },
  methods: {
    next: function() {
      this.currentDate.setMonth(this.currentDate.getMonth()+1)
      this.updatePracticeRecodes().then(() => {
        this.fetchFullYearData()
        this.fetchMonthData()
      })
    },
    back: function() {
      this.currentDate.setMonth(this.currentDate.getMonth()-1)
      this.updatePracticeRecodes().then(() => {
        this.fetchFullYearData()
        this.fetchMonthData()
      })
    },
    updatePracticeRecodes: async function() {
      const dateListOfCalendarRange = this.get_month_calendar(this.currentDate.getFullYear(), this.currentDate.getMonth()+1)
      const firstCalendar = dateListOfCalendarRange[0]
      const from = `${firstCalendar.year}-${firstCalendar.month}-${firstCalendar.day}`
      const lastCalendar = dateListOfCalendarRange[dateListOfCalendarRange.length - 1]
      const to = `${lastCalendar.year}-${lastCalendar.month}-${lastCalendar.day}`

      await this.$store.dispatch('getPracticeRecodes', { userId: this.userId, from: from, to: to })
    },
    // 1週間ごと、合計1ヶ月分を取得
    fetchFullYearData: function() {
      const dateListOfCalendarRange = this.get_month_calendar(this.currentDate.getFullYear(), this.currentDate.getMonth()+1)

      let date = []
      let count = []
      const self = this
      for (let i = 0; i+7 <= dateListOfCalendarRange.length; i+=7) {
        let calenderFrom = dateListOfCalendarRange[i]
        let from = `${calenderFrom.year}-${calenderFrom.month}-${calenderFrom.day}`
        let rages = self.$store.state.practiceRecodes.filter((practiceRecode) => {
          return moment(practiceRecode.practice_date).isBetween(from, (moment(from).add(+7, 'days')), 'day', '[)')
        })
        date.push(`${calenderFrom.month}/${calenderFrom.day}`)
        count.push(rages.length)
      }

      const subject = `${this.currentDate.getFullYear()}/${this.currentDate.getMonth()+1}`
      EventBus.$emit('open-bar-chart', date, count, subject)
    },
    // 1ヶ月分まるっと取得
    fetchMonthData: async function(MonthAndDate) {
      let practiceRecodes

      if (MonthAndDate) {
        const from = moment(MonthAndDate).format('YYYY-MM-DD')
        const to = moment(from).add(+6, 'days').format('YYYY-MM-DD')
        practiceRecodes = await axios.get(`/api/users/${this.userId}/practice_recodes/?date[]=${from}&date[]=${to}`)
        practiceRecodes = practiceRecodes.data.practice_recodes
      } else {
        practiceRecodes = this.$store.state.practiceRecodes
      }

      const group = practiceRecodes.reduce((result, current) => {
        const element = result.find((p) => p.off_road_circuit_id === current.off_road_circuit_id)
        if (element) {
          element.count ++
        } else {
          result.push({
            off_road_circuit_id: current.off_road_circuit_id,
            off_road_circuit_name: current.off_road_circuit_name,
            count: 1,
          })
        }
        return result
      }, [])

      let count = []
      let name = []
      group.forEach(o => {
        count.push(o.count)
        name.push(o.off_road_circuit_name)
      })

      const currentMonthAndDate = MonthAndDate ? `${MonthAndDate}週` : `${this.currentDate.getFullYear()}/${this.currentDate.getMonth()+1}`
      EventBus.$emit('open-pie-chart', count, name, currentMonthAndDate)
    }
  }
}
</script>
