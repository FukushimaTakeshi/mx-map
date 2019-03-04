<template>
  <span>
    <div v-for="(practiceRecode, index) in this.practiceRecodes" :key="index" class="media">
      <div class="media-left">
        <figure class="image is-96x96">
          <img :src="'http://placehold.it/100/?text=no-image'" alt="Image">
        </figure>
      </div>
      <div class="media-content">
        <div class="content">
          <p>
            <strong>{{ practiceRecode.off_road_circuit_name }}</strong>
            <br>
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
  data() {
    return {
      practiceRecodes: []
    }
  },
  mounted() {
    this.practiceRecodes = this.$store.state.practiceRecodes
  },
}

</script>
<style>
</style>
