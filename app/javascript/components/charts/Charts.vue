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
  mounted: function() {
    EventBus.$on('change-pie-chart', this.fetchMonthData)
  },
  created() {
    // BarChart Data
    this.fetchFullYearData()
    // PieChart Data
    this.fetchMonthData()
  },
  methods: {
    next: function() {
      this.currentDate.setMonth(this.currentDate.getMonth()+1)
      this.fetchFullYearData()
      this.fetchMonthData()
    },
    back: function() {
      this.currentDate.setMonth(this.currentDate.getMonth()-1)
      this.fetchFullYearData()
      this.fetchMonthData()
    },
    fetchFullYearData: async function() {
      const calendarYear = this.currentDate.getFullYear()
      const calenderMonth = this.currentDate.getMonth()+1
      let dateListOfCalendarRange = this.get_month_calendar(calendarYear, calenderMonth)

      let chartFullYearData = []
      for (let i = 0; i+7 <= dateListOfCalendarRange.length; i+=7) {
        const calenderFrom = dateListOfCalendarRange[i]
        const from = `${calendarYear}-${calenderFrom.month}-${calenderFrom.day}`
        const calenderTo = dateListOfCalendarRange[i+6]
        const to = `${calendarYear}-${calenderTo.month}-${calenderTo.day}`

        const res = await axios.get(`/api/plans/?user_id=${this.userId}&date[]=${from}&date[]=${to}`)
        if (res.status !== 200) {
          process.exit()
        }

        chartFullYearData.push(
          {
            date : `${calenderFrom.month}/${calenderFrom.day}`,
            count: res.data.plans.length
          }
        )
      }
      let date = []
      for(let val in chartFullYearData){
        date.push(chartFullYearData[val].date)
      }
      let count = []
      for(let val in chartFullYearData){
        count.push(chartFullYearData[val].count)
      }
      const subject = `${this.currentDate.getFullYear()}/${this.currentDate.getMonth()+1}`
      EventBus.$emit('open-bar-chart', date, count, subject)
    },
    fetchMonthData: async function(MonthAndDate) {
      let from // 月初
      let to // 月末
      const toDay = new Date();

      if (MonthAndDate) {
        const arr = MonthAndDate.split('/')
        from = new Date(MonthAndDate)
        let tmpDate = new Date(MonthAndDate)
        to = new Date(tmpDate.setDate(tmpDate.getDate() + 6))
      } else {

        const dateListOfCalendarRange = this.get_month_calendar(this.currentDate.getFullYear(), this.currentDate.getMonth()+1)
        const firstCalendar = dateListOfCalendarRange[0]
        from = `${firstCalendar.year}-${firstCalendar.month}-${firstCalendar.day}`
        const lastCalendar = dateListOfCalendarRange[dateListOfCalendarRange.length - 1]
        to = `${lastCalendar.year}-${lastCalendar.month}-${lastCalendar.day}`
      }

      // 1ヶ月分のデータを取得
      const res = await axios.get(`/api/plans/?user_id=${this.userId}&date[]=${from}&date[]=${to}`)
      if (res.status !== 200) {
        process.exit()
      }
      let circuitList = res.data.off_road_circuits
      // 日付順(昇順)に並び替え
      circuitList.sort(function(a,b){
        if(a.id < b.id) return -1
        if(a.id > b.id) return 1
        return 0
      })

      let count = []
      let name = []
      circuitList.forEach(function(value) {
        count.push(value.length)
        name.push(value[0].name)
      })
      if (MonthAndDate) {
        MonthAndDate = `${MonthAndDate}週`
      }
      const currentMonthAndDate = MonthAndDate || `${this.currentDate.getFullYear()}/${this.currentDate.getMonth()+1}`
      EventBus.$emit('open-pie-chart', count, name, currentMonthAndDate)
    }
  }
}
</script>
