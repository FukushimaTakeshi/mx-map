<template>
  <span>
    <div v-for="(practiceRecode, index) in practiceRecodes" :key="index" class="media">
      <div class="media-left">
        <figure class="image is-48x48">
          <img :src="'https://placehold.it/100/?text=no-image'" alt="Image">
        </figure>
      </div>
      <div class="media-content">
        <div class="content">
          <p>
            <strong>{{ practiceRecode.practice_date }}</strong>
            <small>{{ practiceRecode.off_road_circuit_name }}</small>
            <br>
            {{ practiceRecode.comment }}
          </p>
        </div>
      </div>
    </div>
  </span>
</template>
<script>
import axios from 'axios'
import moment from 'moment'

export default {
  props: ['userId'],
  // data() {
  //   return {
  //     practiceRecodes: []
  //   }
  // },
  // created() {
  //   this.practiceRecodes = this.$store.state.practiceRecodes
  // },
  computed: {
    practiceRecodes() {
      return this.$store.state.practiceRecodes
    }
  }
}

</script>
<style>
</style>
