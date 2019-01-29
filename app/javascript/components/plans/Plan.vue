<template>
  <span class="plan">
    <div class="vue-slide">
      <div @click="back()" :disabled="visible_content == 0" class="vue-slide__back">
        <p class="icon is-medium mdi-18px">
          <i class="fas fa-angle-left"></i>
        </p>
      </div>

      <transition :name="transition_name">
        <div class="vue-slide__body"
          :key="index"
          v-for="(dateList, index) in dateList"
          v-if="visible_content == index">

          <div class="vue-slide__days">
            <div v-for="(holiday, index) in holidayList" :key="holiday.id" class="has-text-centered">
              <div class="vue-slide__day">
                <p class="heading">
                  {{ holiday.date}}{{ holiday.day }}に走るよ！
                </p>

                <p v-if="holiday.exists" class="title-em icon mdi-18px has-text-link">
                  <i class="fas fa-heart"></i>
                  <span class="attendance" @click="deleteAttendance(holiday.date, index)">{{ holiday.attendance }}</span>
                </p>
                <p v-else class="title-em icon mdi-18px">
                  <i class="fas fa-heart"></i>
                  <span class="attendance" @click="createAttendance(holiday.date, index)">{{ holiday.attendance }}</span>
                </p>
                <span class="is-units">人</span>
              </div>
            </div>
          </div>

        </div>
      </transition>

      <div @click="next()" :disabled="visible_content == dateList.length - 1" class="vue-slide__next">
        <p class="icon is-medium mdi-18px">
          <i class="fas fa-angle-right"></i>
        </p>
      </div>
    </div>
  </span>
</template>

<script>
import axios from 'axios'
import JapaneseHolidays from 'japanese-holidays'
import { csrfToken } from 'rails-ujs'
axios.defaults.headers.common['X-CSRF-TOKEN'] = csrfToken()

export default {
  props: [
    'circuitId',
    'userId'
  ],
  data() {
    return {
      holidayList: [],
      transition_name: 'show-next',
      dateList: [1, 2],
      visible_content: 0,
    }
  },
  created: function() {
    const today = new Date()
    let saturday = new Date()
    let sunday = new Date()
    saturday.setDate(today.getDate() + 6 - today.getDay())
    saturday = `${saturday.getFullYear()}-${saturday.getMonth() + 1}-${saturday.getDate()}`

    sunday.setDate(today.getDate() + 7 - today.getDay())
    sunday = `${sunday.getFullYear()}-${sunday.getMonth() + 1}-${sunday.getDate()}`

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

    this.holidayList.forEach((holiday, index) => {
      this.getAttendance(holiday.date, index)
    })
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
      saturday = `${saturday.getFullYear()}-${saturday.getMonth() + 1}-${saturday.getDate()}`

      sunday.setDate(today.getDate() + 7 - today.getDay())
      sunday = `${sunday.getFullYear()}-${sunday.getMonth() + 1}-${sunday.getDate()}`

      this.holidayList[0].date = saturday
      this.holidayList[1].date = sunday

      this.holidayList.forEach((holiday, index) => {
        this.getAttendance(holiday.date, index)
      })
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
      saturday = `${saturday.getFullYear()}-${saturday.getMonth() + 1}-${saturday.getDate()}`

      sunday.setDate(today.getDate() + 7 - today.getDay() + 7)
      sunday = `${sunday.getFullYear()}-${sunday.getMonth() + 1}-${sunday.getDate()}`

      this.holidayList[0].date = saturday
      this.holidayList[1].date = sunday

      this.holidayList.forEach((holiday, index) => {
        this.getAttendance(holiday.date, index)
      })
    },

    getAttendance: async function(date, index) {
      const res = await axios.get(`/api/plans/?off_road_circuit_id=${this.circuitId}&date=${date}&all=1`)
      if (res.status !== 200) {
        process.exit()
      }
      this.holidayList[index].attendance = res.data.plans.length

      const singnedInUserPlan = res.data.plans.find((plan) => {
        return (this.userId === plan['user_id'])
      })

      if (singnedInUserPlan || res.data.id) {
        this.holidayList[index].exists = true
        this.holidayList[index].planId = (res.data.id || singnedInUserPlan['id'])
      } else {
        this.holidayList[index].exists = false
      }
    },

    createAttendance: async function(date, index) {
      const res = await axios.post(`/api/plans/`, {date: date, off_road_circuit_id: this.circuitId })
      if (res.status !== 201) {
        process.exit()
      }
      this.getAttendance(date, index)
    },

    deleteAttendance: async function(date, index) {
      const res = await axios.delete(`/api/plans/${this.holidayList[index].planId}`)
      if (res.status !== 200) {
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

<style lang="scss">
.show-next-enter-active, .show-next-leave-active,
.show-prev-enter-active, .show-prev-leave-active  {
  transition: all .1s;
}
.show-next-enter, .show-prev-leave-to {
  transform: translateX(100%);
}
.show-next-leave-to, .show-prev-enter {
  transform: translateX(-100%);
}

.vue-slide{
  display: flex;
  flex-wrap: nowrap;
  height: auto;
  align-content: space-between;
  justify-content: space-between;
  align-items: center;

  &__body {
  }
  &__days {
    display: flex;
  }
  &__day {
    margin: 3px 2px;
  }
  &__back {
  }
  &__next {
  }
}

.attendance {
  margin: 1px 4px;
}

.is-units {
  font-size: xx-small;
  margin: 1px 1px;
}
</style>
