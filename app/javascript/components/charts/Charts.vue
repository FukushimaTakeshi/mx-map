<template>
  <div class="columns is-gapless is-multiline is-mobile">

    <div class="column is-half">
      <practice-bar-chart :chartFullYearData="chartFullYearData"></practice-bar-chart>
    </div>

    <div class="column is-half">
      <practice-pie-chart></practice-pie-chart>
    </div>

  </div>
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
      chartFullYearData: []
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
    fetchFullYearData: async function() {
      const toDay = new Date();
      let calenderData = this.get_month_calendar(toDay.getFullYear(), toDay.getMonth()+1)
    
      for (let i = 0; i+7 <= calenderData.length; i+=7) {
        const calenderFrom = calenderData[i]
        const from = `${toDay.getFullYear()}-${calenderFrom.month}-${calenderFrom.day}`
        const calenderTo = calenderData[i+6]
        const to = `${toDay.getFullYear()}-${calenderTo.month}-${calenderTo.day}`

        const res = await axios.get(`/api/plans/?user_id=${this.userId}&date[]=${from}&date[]=${to}`)
        if (res.status !== 200) {
          console.log("Error!!")
          process.exit()
        }
        this.chartFullYearData.push(
          {
            date : `${calenderFrom.month}/${calenderFrom.day}`,
            count: res.data.plans.length
          }
        )
      }
      let date = []
      for(let val in this.chartFullYearData){
        date.push(this.chartFullYearData[val].date)
      }
      let count = []
      for(let val in this.chartFullYearData){
        count.push(this.chartFullYearData[val].count)
      }
      EventBus.$emit('open-bar-chart', date, count)
    },
    fetchMonthData: async function(MonthAndDate) {
      let from // 月初
      let to // 月末

      if (MonthAndDate) {
        const arr = MonthAndDate.split('/')
        from = new Date(MonthAndDate)
        let tmpDate = new Date(MonthAndDate)
        to = new Date(tmpDate.setDate(tmpDate.getDate() + 6))
      } else {
        from = new Date()
        from.setDate(1)
        to = new Date()
        to.setDate(1)
        to.setMonth(to.getMonth() + 1)
        to.setDate(0)
      }

      // 1ヶ月分のデータを取得
      const res = await axios.get(`/api/plans/?user_id=${this.userId}&date[]=${from}&date[]=${to}`)
      if (res.status !== 200) {
        console.log("Error!!")
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
      let currentMonthAndDate = MonthAndDate || `${from.getFullYear()}/${from.getMonth()+1}`
      EventBus.$emit('open-pie-chart', count, name, currentMonthAndDate)
    }
  }
}
</script>