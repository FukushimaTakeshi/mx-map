<template>
  <div class="plan">
    <span v-if="exists" class="title-em icon mdi-18px has-text-link">
      <i class="fas fa-heart"></i>
      <span v-on:click="deleteAttendance" :data-id="planId">{{ attendance }}</span>
    </span>
    <span v-else class="title-em icon mdi-18px">
      <i class="fas fa-heart"></i>
      <span v-on:click="createAttendance">{{ attendance }}</span>
    </span>
  </div>
</template>

<script>
import axios from 'axios'
import { csrfToken } from 'rails-ujs'
axios.defaults.headers.common['X-CSRF-TOKEN'] = csrfToken()

export default {
  props: {
    circuitId: 0
  },
  data() {
    return {
      planId: null,
      attendance: 0,
      exists: false
    }
  },
  mounted: function() {
    this.getAttendance()
  },
  methods: {
    getAttendance: async function() {
      const res = await axios.get(`/plans/?off_road_circuit_id=${this.circuitId}`)
      if (res.status !== 200) {
        console.log("Error!!")
        process.exit()
      }
      this.attendance = res.data.plans

      if (res.data.id == null) {
        this.exists = false
      } else {
        this.exists = true
        this.planId = res.data.id
      }
    },

    createAttendance: async function() {
      const res = await axios.post(`/plans/`, {date: '2018-06-13', off_road_circuit_id: this.circuitId })
      if (res.status !== 200) {
        console.log("Error!!")
        process.exit()
      }
      this.getAttendance()
      console.log(holidayThisWeek())
    },

    deleteAttendance: async function() {
      const res = await axios.delete(`/plans/${this.planId}`)
      if (res.status !== 200) {
        console.log("Error!!")
        process.exit()
      }
      this.getAttendance()
    },
  }
}

function holidayThisWeek() {
  const today = new Date()

  if (today.getDay() !== 1) {
    today.setDate(today.getDate() - today.getDay() + 1)
  } else if (today.getDay() == 0) {
    today.setDate(today.getDate() - 6)
  }

  const holidays = JapaneseHolidays.getHolidaysOf(today.getFullYear())

  var holidayList = holidays.filter(
    function (holiday) {
      return(
        (today.getMonth()+1) == holiday.month &&
          (today.getDate() <= holiday.date) && (today.getDate() > (holiday.date - 5))
      )
    }
  )
  return holidayList

}
</script>
