<template>
  <practice-pie-chart></practice-pie-chart>
</template>

<script>
import axios from 'axios'
import PracticePieChart from './PracticePieChart.vue'
import EventBus from '../../packs/users/form.js'

export default {
  components: {
    PracticePieChart
  },
  props: [
    'userId'
  ],
  data() {
    return {
      chartMonthData: []
    }
  },
  mounted: function() {
    EventBus.$on('change-pie-chart', this.fetchMonthData)
  },
  created() {
    this.fetchMonthData()
  },
  methods: {
    fetchMonthData: async function(yearMonth) {
      let from // 月初
      let to // 月末

      if (yearMonth) {
        const arr = yearMonth.split('-')
        from = new Date(arr[0], arr[1] - 1, 1)
        to = new Date(arr[0], arr[1] - 1, 1)
      } else {
        from = new Date()
        from.setDate(1)
        to = new Date()
      }
      to.setDate(1)
      to.setMonth(to.getMonth() + 1)
      to.setDate(0)

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
      let currentYearMonth = yearMonth || `${from.getFullYear()}-${from.getMonth()+1}`
      EventBus.$emit('open-pie-chart', count, name, currentYearMonth)
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
