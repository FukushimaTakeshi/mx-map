import 'babel-polyfill'
import Vue from 'vue'
import Vuex from 'vuex'
import axios from 'axios'

Vue.use(Vuex)

const store = new Vuex.Store({
  strict: process.env.NODE_ENV !== 'production',
  state: {
    practiceRecodes: []
  },
  mutations: {
    setPracticeRecodes (state, payload) {
      state.practiceRecodes = payload
    }
  },
  actions: {
    async getPracticeRecodes ({ commit }, { userId, from, to }) {
      await axios.get(`/api/users/${userId}/practice_recodes/?date[]=${from}&date[]=${to}`)
        .then((res) => {
          if (res.status === 200) {
            commit('setPracticeRecodes', res.data.practice_recodes)
          } else {
            commit('setPracticeRecodes', [])
          }
        })
        .catch((res) => {
          console.log(res)
          throw res
        })
    }
  }
})
export default store
