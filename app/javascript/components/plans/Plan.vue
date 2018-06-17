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
      planId: 0,
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
      this.exists = res.data.exists
      this.planId = res.data.id
    },

    createAttendance: async function() {
      const res = await axios.post(`/plans/`, {date: '2018-06-13', off_road_circuit_id: this.circuitId })
      if (res.status !== 200) {
        console.log("Error!!")
        process.exit()
      }
      this.getAttendance()
    },

    deleteAttendance: async function() {
      const res = await axios.delete(`/plans/${this.planId}`)
      if (res.status !== 200) {
        console.log("Error!!")
        process.exit()
      }
      this.getAttendance()
    }
  }
}
</script>
