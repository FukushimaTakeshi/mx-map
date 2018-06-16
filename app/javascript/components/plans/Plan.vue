<template>
  <div class="plan">
    <div v-on:click.once="putAttendance">{{ attendance }}</div>
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
      attendance: 0,
    }
  },
  mounted: function() {
    this.getAttendance()
  },
  methods: {
    getAttendance: async function() {
      const res = await axios.get(`/plans/${this.circuitId}`)
      if (res.status !== 200) {
        console.log("Error!!")
        process.exit()
      }
      this.attendance = res.data.plans.attendance
    },

    putAttendance: async function() {
      const res = await axios.put(`/plans/${this.circuitId}`, { circuit_id: this.circuitId })
      if (res.status !== 200) {
        console.log("Error!!")
        process.exit()
      }
      this.getAttendance()
    }
  }
}
</script>
