<template>
  <practice-bar-chart :chartFullYearData="chartFullYearData"></practice-bar-chart>
</template>

<script>
import axios from 'axios'
import PracticeBarChart from './PracticeBarChart.vue'
import EventBus from '../../packs/users/form.js'

export default {
  components: {
    PracticeBarChart
  },
  props: [
    'userId'
  ],
  data() {
    return {
      chartFullYearData: []
    }
  },
  created() {
    this.fetchFullYearData()
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
    }
  }
}
</script>
