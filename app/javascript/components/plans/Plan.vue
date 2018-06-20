<template>
  <span class="plan">
    <nav class="level is-mobile">
      <!-- スライドする部分。keyを持たせることで、それぞれが個別の要素であることを示す。 -->
      <transition :name="transition_name">
        <div class="vue-carousel_body"
          :key="index"
          v-for="(dateList, index) in dateList"
          v-if="visible_content == index">
          <!-- :style="{backgroundColor: content.bg_color}"> -->
          <nav class="level is-mobile">
            <div v-for="(holiday, index) in holidayList" :key="holiday.id" class="level-item has-text-centered">
              <div>
                <p class="heading">
                  {{ holiday.date}}{{ holiday.day, getAttendance(holiday.date, index) }}に走るよ！
                </p>

                <p v-if="holiday.exists" class="title-em icon mdi-18px has-text-link">
                  <i class="fas fa-heart"></i>
                  <span v-on:click="deleteAttendance(holiday.date, index)">{{ holiday.attendance }}</span>
                </p>
                <p v-else class="title-em icon mdi-18px">
                  <i class="fas fa-heart"></i>
                  <span v-on:click="createAttendance(holiday.date, index)">{{ holiday.attendance }}</span>
                </p>
              </div>
            </div>
          </nav>

        </div>
      </transition>

      <!-- 「PREV」「NEXT」と現在地のドット -->
      <div class="vue-carousel_footer">
        <div @click="back()" :disabled="visible_content == 0">
          <i class="fas fa-angle-left"></i>
        </div>
        <!-- <button @click="back()" :disabled="visible_content == 0">今週</button> -->
        <!-- <div class="vue-carousel_footer_dot"
          v-for="(dateList, index) in dateList"
          :class="{'is-visible' : visible_content == index}"></div> -->
        <div @click="next()" :disabled="visible_content == dateList.length - 1">
          <i class="fas fa-angle-right"></i>
        </div>
        <!-- <button @click="next()" :disabled="visible_content == dateList.length - 1">来週</button> -->
      </div>

      <!-- <div v-for="(holiday, index) in holidayList" :key="holiday.id" class="level-item has-text-centered">
        <div>
          <p class="heading">
            {{ holiday.date}}{{ holiday.day, getAttendance(holiday.date, index) }}に走るよ！
          </p>

          <p v-if="holiday.exists" class="title-em icon mdi-18px has-text-link">
            <i class="fas fa-heart"></i>
            <span v-on:click="deleteAttendance(holiday.date, index)">{{ holiday.attendance }}</span>
          </p>
          <p v-else class="title-em icon mdi-18px">
            <i class="fas fa-heart"></i>
            <span v-on:click="createAttendance(holiday.date, index)">{{ holiday.attendance }}</span>
          </p>
        </div>
      </div> -->
    </nav>
  </span>
</template>

<script>
import axios from 'axios'
import JapaneseHolidays from 'japanese-holidays'
import { csrfToken } from 'rails-ujs'
axios.defaults.headers.common['X-CSRF-TOKEN'] = csrfToken()

export default {
  props: ['circuitId'],
  data() {
    return {
      holidayList: [],
      transition_name: 'show-next',
      dateList: [1, 2],
      visible_content: 0,
    }
  },
  mounted: function() {
    const today = new Date()
    let saturday = new Date()
    let sunday = new Date()
    saturday.setDate(today.getDate() + 6 - today.getDay())
    saturday = `${saturday.getFullYear()}-${saturday.getMonth()}-${saturday.getDate()}`

    sunday.setDate(today.getDate() + 7 - today.getDay())
    sunday = `${sunday.getFullYear()}-${sunday.getMonth()}-${sunday.getDate()}`

    this.holidayList = [
      {
        id: 0,
        planId: 0,
        date: saturday,
        day: '(土)',
        exists: false,
        attendance: 0
      },
      {
        id: 1,
        planId: 0,
        date: sunday,
        day: '(日)',
        exists: false,
        attendance: 0
      }
    ]
  },
  methods: {

    back: function() {
      if (this.visible_content == 0) {
        return false
      }
      this.transition_name = 'show-prev'
      this.visible_content--
      const today = new Date()
      let saturday = new Date()
      let sunday = new Date()
      saturday.setDate(today.getDate() + 6 - today.getDay())
      saturday = `${saturday.getFullYear()}-${saturday.getMonth()}-${saturday.getDate()}`

      sunday.setDate(today.getDate() + 7 - today.getDay())
      sunday = `${sunday.getFullYear()}-${sunday.getMonth()}-${sunday.getDate()}`

      this.holidayList[0].date = saturday
      this.holidayList[1].date = sunday
    },
    next: function() {
      if (this.visible_content == 1) {
        return false
      }
      this.transition_name = 'show-next'
      this.visible_content++
      const today = new Date()
      let saturday = new Date()
      let sunday = new Date()
      saturday.setDate(today.getDate() + 6 - today.getDay() + 7)
      saturday = `${saturday.getFullYear()}-${saturday.getMonth()}-${saturday.getDate()}`

      sunday.setDate(today.getDate() + 7 - today.getDay() + 7)
      sunday = `${sunday.getFullYear()}-${sunday.getMonth()}-${sunday.getDate()}`

      this.holidayList[0].date = saturday
      this.holidayList[1].date = sunday
    },

    getAttendance: async function(date, index) {
      const res = await axios.get(`/plans/?off_road_circuit_id=${this.circuitId}&date=${date}`)
      if (res.status !== 200) {
        console.log("Error!!")
        process.exit()
      }
      this.holidayList[index].attendance = res.data.plans

      if (res.data.id == null) {
        this.holidayList[index].exists = false
      } else {
        this.holidayList[index].exists = true
        this.holidayList[index].planId = res.data.id
      }
    },

    createAttendance: async function(date, index) {
      const res = await axios.post(`/plans/`, {date: date, off_road_circuit_id: this.circuitId })
      if (res.status !== 200) {
        console.log("Error!!")
        process.exit()
      }
      this.getAttendance(date, index)
    },

    deleteAttendance: async function(date, index) {
      const res = await axios.delete(`/plans/${this.holidayList[index].planId}`)
      if (res.status !== 200) {
        console.log("Error!!")
        process.exit()
      }
      this.getAttendance(date, index)
    },
  }
}

function holidayThisWeek() {
  let today = new Date()

  if (today.getDay() !== 1) {
    today.setDate(today.getDate() - today.getDay() + 1)
  } else if (today.getDay() == 0) {
    today.setDate(today.getDate() - 6)
  }

  const holidays = JapaneseHolidays.getHolidaysOf(today.getFullYear())

  var holidayList = holidays.filter(
    function (holiday) {
      return(
        (today.getMonth()+1) == holiday.month &&
          (today.getDate() <= holiday.date) && (today.getDate() > (holiday.date - 5))
      )
    }
  )
  return holidayList

}
</script>
