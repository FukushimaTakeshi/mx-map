<template>
  <span>
    <a v-for="item in this.favoriteCourses" :key="item.id"
       :href="offRoadCircuitsUrl(item.off_road_circuit_id)" 
       class="media" data-turbolinks="false">
      <div class="media-left">
        <figure class="image is-96x96">
          <img :src="item.photo_url || 'http://placehold.it/100/?text=no-image'" alt="Image">
        </figure>
      </div>
      <div class="media-content">
        <div class="content">
          <p>
            <strong>{{ item.name }}</strong>
            <br>
          </p>
        </div>
      </div>
    </a>
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
  mounted: async function() {
    const res = await axios.get(`/api/users/${this.userId}/favorite_courses`)
    if (res.status !== 200) {
      process.exit()
    }
    this.favoriteCourses = res.data.favorite_courses
  },
  methods: {
    offRoadCircuitsUrl: function(circuitId) {
      return `/off_road_circuits/${circuitId}/`
    }
  }
}
</script>
