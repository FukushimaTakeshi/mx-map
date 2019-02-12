<template>
  <span>
    <div class="columns is-gapless is-multiline is-mobile">
      <b-loading :active.sync="loading"></b-loading>
      <div class="column is-half">
        <practice-bar-chart />
      </div>

      <div class="column is-half">
        <practice-pie-chart />
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
      currentDate: moment().toDate()
    }
  },
  created() {
    this.updatePracticeRecodes().then(() => {
      this.fetchBarChartData()
      this.fetchPieChartData()
    })
    EventBus.$on('week-pie-chart', this.fetchWeekData)
    EventBus.$on('default-pie-chart', this.fetchPieChartData)
    this.$root.eventBus.$on('refresh-charts', this.refreshCharts)
  },
  methods: {
    next: function() {
      this.currentDate = moment(this.currentDate).add(+1, 'months').toDate()
      this.updatePracticeRecodes().then(() => {
        this.fetchBarChartData()
        this.fetchPieChartData()
      })
    },
    back: function() {
      this.currentDate = moment(this.currentDate).add(-1, 'months').toDate()
      this.updatePracticeRecodes().then(() => {
        this.fetchBarChartData()
        this.fetchPieChartData()
      })
    },
    refreshCharts: function() {
      this.currentDate = moment().toDate()
      this.updatePracticeRecodes().then(() => {
        this.fetchBarChartData()
        this.fetchPieChartData()
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
    fetchBarChartData: function() {
      const dateListOfCalendarRange = this.get_month_calendar(this.currentDate.getFullYear(), this.currentDate.getMonth()+1)

      let date = []
      let count = []
      for (let i = 0; i+7 <= dateListOfCalendarRange.length; i+=7) {
        let calenderFrom = dateListOfCalendarRange[i]
        let from = `${calenderFrom.year}-${calenderFrom.month}-${calenderFrom.day}`
        let rages = this.$store.state.practiceRecodes.filter((practiceRecode) => {
          return moment(practiceRecode.practice_date).isBetween(from, (moment(from).add(+7, 'days')), 'day', '[)')
        })
        date.push(`${calenderFrom.month}/${calenderFrom.day}`)
        count.push(rages.length)
      }

      const subject = `${this.currentDate.getFullYear()}/${this.currentDate.getMonth()+1}`
      EventBus.$emit('open-bar-chart', date, count, subject)
    },
    fetchPieChartData: function() {
      const group = this.groupByCircuit(this.$store.state.practiceRecodes)
      const currentMonthAndDate = `${this.currentDate.getFullYear()}/${this.currentDate.getMonth()+1}`

      EventBus.$emit('open-pie-chart', group.count, group.name, currentMonthAndDate)
    },
    // 選択肢した週のみ
    fetchWeekData: async function(MonthAndDate) {
      const from = moment(MonthAndDate).format('YYYY-MM-DD')
      const to = moment(from).add(+6, 'days').format('YYYY-MM-DD')
      const group = await axios.get(`/api/users/${this.userId}/practice_recodes/?date[]=${from}&date[]=${to}`).then((res) => {
        return this.groupByCircuit(res.data.practice_recodes)
      })

      EventBus.$emit('open-pie-chart', group.count, group.name, `${MonthAndDate}週`)
    },
    groupByCircuit: function(practiceRecodes) {
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

      const count = group.map((val) => val.count)
      const name = group.map((val) => val.off_road_circuit_name)

      return { count: count, name: name }
    }
  }
}
</script>
