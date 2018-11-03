<template>
  <span>
    <span v-show="isFavoriteCourse" @click="deleteFavoriteCircuit()" class="icon is-medium has-text-warning">
      <i class="fas fa-lg fa-star"></i>
    </span>
    <span v-show="!isFavoriteCourse" @click="registerFavoriteCircuit()" class="icon is-medium has-text-warning">
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
      isFavoriteCourse: false,
      favoriteCourseList: this.favoriteCourses,
      favoriteCircuit: null
    }
  },
  created: function() {
    if (this.findFavoriteCourse()) {
      this.isFavoriteCourse = true
    }
  },
  methods: {
    findFavoriteCourse: function() {
      const favoriteCircuit = this.favoriteCourseList.find((course) => {
        return (course.off_road_circuit_id === this.circuitId)
      })
      return favoriteCircuit
    },
    registerFavoriteCircuit: async function() {
      const res = await axios.post(`/api/users/${this.userId}/favorite_courses`, { off_road_circuit_id: this.circuitId })
      if (res.status !== 200) {
        process.exit()
      }
      this.findAllFavoriteCourse().then(result => {
        this.favoriteCourseList = result
        if (this.findFavoriteCourse()) {
          this.isFavoriteCourse = true
        }else{
          this.isFavoriteCourse = false
        }
      })
    },
    deleteFavoriteCircuit: async function() {
      const favoriteCircuit = this.findFavoriteCourse()
      const res = await axios.delete(`/api/users/${this.userId}/favorite_courses/${favoriteCircuit.id}`)
      if (res.status !== 200) {
        process.exit()
      }
      this.favoriteCourseList = this.favoriteCourseList.filter(n => n.id !== favoriteCircuit.id)
      if (this.findFavoriteCourse()) {
        this.isFavoriteCourse = true
      }else{
        this.isFavoriteCourse = false
      }
    },
    findAllFavoriteCourse: async function() {
      const res = await axios.get(`/api/users/${this.userId}/favorite_courses`)
      if (res.status !== 200) {
        process.exit()
      }
      return res.data.favorite_courses
    }
  }
}
</script>
