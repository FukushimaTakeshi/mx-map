<template>
  <span class="list">
    <div @click="fetchFavoriteCourses()">click</div>
    <div v-for="item in this.favoriteCourses" :key="item.id">
      {{ item.off_road_circuit_id }}
      {{ item.name }}
    </div>
  </span>
</template>

<script>
import axios from 'axios'

export default {
  props: ['userId'],
  data() {
    return {
      favoriteCourses: []
    }
  },
  methods: {
    fetchFavoriteCourses: async function(MonthAndDate) {
      const res = await axios.get(`/api/users/${this.userId}/favorite_courses`)
      if (res.status !== 200) {
        console.log("Error!!")
        process.exit()
      }
      this.favoriteCourses = res.data.favorite_courses
    }
  }
}
</script>

<style lang="scss">
</style>
