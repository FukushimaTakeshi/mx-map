<template>
  <div>
    <div class="menu is-multiline is-centered">
      <div v-for="region in this.regionList" :key="region.id">
        <ul class="menu-list">
          <li>
            <a class="is-active" @click="setArea(region.id)">
              {{ region.name }}
            </a>

            <transition name="bounce">
              <ul v-if="selectedArea === region.id">
                <div v-for="prefecture in region.prefectures" :key="prefecture.id">
                  <li @click="findByCircuits(prefecture.id)">
                    {{ prefecture.name }}
                  </li>
                </div>
              </ul>
            </transition>
          </li>
        </ul>
      </div>
    </div>

    <article v-for="circuit in this.OffRoadCircuitList" class="media">
      <div class="media-left">
        <figure class="image is-96x96">
          <img :src="circuit.photo_url || 'http://placehold.it/100/?text=no-image'" alt="Image">
        </figure>
      </div>
      <div @click="registerFavoriteCircuit(circuit.id)" class="media-content">
        <div class="content">
          <p>
            <strong>{{ circuit.name }}</strong>
            <br>
            </p>
        </div>
        <nav class="level is-mobile">
          <div class="level-left">
            <a class="level-item" aria-label="reply">
              <span class="icon is-small">
                <i class="fas fa-reply" aria-hidden="true"></i>
              </span>
            </a>
          </div>
        </nav>
      </div>
    </article>
  </div>

</template>

<script>
  import axios from 'axios'
  import { csrfToken } from 'rails-ujs'
  axios.defaults.headers.common['X-CSRF-TOKEN'] = csrfToken()

  export default {
    props: ['userId'],
    data() {
      return {
        regionList: [],
        OffRoadCircuitList: [],
        selectedArea: null
      }
    },
    mounted: async function() {
      const res = await axios.get('/api/regions')
      if (res.status !== 200) {
        process.exit()
      }
      this.regionList = res.data
    },
    methods: {
      findByCircuits: async function(prefectureId) {
        const res = await axios.get(`/api/off_road_circuits/?prefecture_id=${prefectureId}`)
        if (res.status !== 200) {
          process.exit()
        }
        this.OffRoadCircuitList = res.data.off_road_circuits
      },
      registerFavoriteCircuit: async function(circuitId) {
        const res = await axios.post(`/api/users/${this.userId}/favorite_courses/`, { off_road_circuit_id: circuitId })
        if (res.status !== 200) {
          process.exit()
        }
      },
      setArea: function(index) {
        if (this.selectedArea == index) {
          this.selectedArea = ""
        } else {
          this.selectedArea = index
        }
      }
    }
  }
</script>
