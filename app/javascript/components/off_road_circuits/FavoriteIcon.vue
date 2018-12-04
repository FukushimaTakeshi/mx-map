<template>
  <span>
    <span v-show="isFavorite" @click="deleteFavoriteCircuit()" class="icon is-medium has-text-warning">
      <i class="fas fa-lg fa-star"></i>
    </span>
    <span v-show="!isFavorite" @click="registerFavoriteCircuit()" class="icon is-medium has-text-warning">
      <i class="far fa-lg fa-star"></i>
    </span>
  </span>
</template>

<script>
import axios from 'axios'

export default {
  props: ['userId', 'favoriteCourses', 'circuitId'],
  data() {
    return {
      favoriteCourseList: this.favoriteCourses
    }
  },
  computed: {
    isFavorite() {
      if (this.favoriteCourseList.length === 0) { return false }
      return Boolean(this.findFavoriteCourse())
    }
  },
  methods: {
    findFavoriteCourse: function() {
      const favoriteCircuit = this.favoriteCourseList.find((course) => {
        return (course.off_road_circuit_id === this.circuitId)
      })
      if (favoriteCircuit) { return favoriteCircuit }
    },
    registerFavoriteCircuit: async function() {
      const res = await axios.post(
        `/api/users/${this.userId}/favorite_courses`,
        { off_road_circuit_id: this.circuitId, user_id: this.userId }
      )
      if (res.status !== 201) { process.exit() }
      this.findAllFavoriteCourse().then(result => {
        this.favoriteCourseList = result
      })
    },
    deleteFavoriteCircuit: async function() {
      const favoriteCircuit = this.findFavoriteCourse()
      const res = await axios.delete(`/api/users/${this.userId}/favorite_courses/${favoriteCircuit.id}`)
      if (res.status !== 200) { process.exit() }
      this.favoriteCourseList = this.favoriteCourseList.filter(n => n.id !== favoriteCircuit.id)
    },
    findAllFavoriteCourse: async function() {
      const res = await axios.get(`/api/users/${this.userId}/favorite_courses`)
      if (res.status !== 200) { process.exit() }
      return res.data.favorite_courses
    }
  }
}
</script>
