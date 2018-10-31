<template>
  <div>
    <div class="column">
      <div class="columns">

        <div class="column is-fullheight is-centered">
          <div class="menu is-multiline is-centered">
            <div v-for="region in this.regionList" :key="region.id">
              <ul class="menu-list">
                <li>
                  <a class="has-text-left" @click="setArea(region.id)">
                    {{ region.name }}
                  </a>

                  <transition name="bounce">
                    <ul v-if="selectedArea === region.id">
                      <div v-for="prefecture in region.prefectures" :key="prefecture.id">
                        <li class="has-text-left" @click="findByCircuits(prefecture.id)">
                          {{ prefecture.name }}
                        </li>
                      </div>
                    </ul>
                  </transition>
                </li>
              </ul>
            </div>
          </div>
        </div>
      
        <div v-if="this.OffRoadCircuitList.length > 0" class="column is-three-quarters is-fullheight is-centered">
          <div class="card events-card">
            <header class="card-header">
              <p class="card-header-title">コース一覧</p>
            </header>
            <div class="card-table">
              <div class="content">
                <table class="table is-fullwidth is-hoverable">
                  <tbody>
                    <tr v-for="circuit in this.OffRoadCircuitList">
                      <td width="5%">
                        <figure class="image is-32x32">
                          <img :src="circuit.photo_url || 'http://placehold.it/32/?text=no-image'" alt="Image">
                        </figure>
                      </td>
                      <td>{{ circuit.name }}</td>
                      <td>
                        <button @click="registerFavoriteCircuit(circuit.id)" class="button is-small is-primary" href="#">
                          お気に入り
                        </button>
                      </td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
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

<style>
  .events-card .card-table {
    max-height: 250px;
    overflow-y: scroll;
  }
</style>
