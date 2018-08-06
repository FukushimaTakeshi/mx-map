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
      for (let i = 0; i < 12; i++) {
        // 月初
        let from = new Date()
        from.setDate(1)
        from.setMonth(from.getMonth() -i + 1)

        // 月末
        let to = new Date()
        to.setDate(1)
        to.setMonth(to.getMonth() - i + 1)
        to.setMonth(to.getMonth() + 1)
        to.setDate(0)

        // 過去12ヶ月分のデータを取得
        const res = await axios.get(`/api/plans/?user_id=${this.userId}&date[]=${from}&date[]=${to}`)
        if (res.status !== 200) {
          console.log("Error!!")
          process.exit()
        }
        this.chartFullYearData.push(
          {
            date : `${from.getFullYear()}-${from.getMonth()+1}`,
            count: res.data.plans.length
          }
        )
      }
      // 日付順(昇順)に並び替え
      this.chartFullYearData.sort(function(a,b){
        if(a.date < b.date) return -1
        if(a.date > b.date) return 1
        return 0
      })

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

async function getAttendance(userId, from, to) {
  const res = await axios.get(`/api/plans/?user_id=${userId}&date[]=${from}&date[]=${to}`)
  if (res.status !== 200) {
    console.log("Error!!")
    process.exit()
  }
  return res.data
}
</script>
