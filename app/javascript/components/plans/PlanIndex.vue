<template>
  <span class="plan">
    <Modal v-if="isOpen" :text="testTxt" @close="closeModal()"></Modal>
    <div class="calendar">
      <div class="calendar-nav">
        <div @click="prev()" class="calendar-nav-previous-month">
          <button class="button is-small is-text">
            <svg viewBox="0 0 50 80" xml:space="preserve">
              <polyline fill="none" stroke-width=".5em" stroke-linecap="round" stroke-linejoin="round" points="45.63,75.8 0.375,38.087 45.63,0.375 "></polyline>
            </svg>
          </button>
        </div>
        <div @click="openModal()" class="calendar-month">{{ currentYear }}年{{ currentMonth }}月</div>
        <div @click="next()" class="calendar-nav-next-month">
          <button class="button is-small is-text">
            <svg viewBox="0 0 50 80" xml:space="preserve">
              <polyline fill="none" stroke-width=".5em" stroke-linecap="round" stroke-linejoin="round" points="0.375,0.375 45.63,38.087 0.375,75.8 "></polyline>
            </svg>
          </button>
        </div>
      </div>
      <div class="calendar-container">
        <div class="calendar-header">
          <div class="calendar-date">Sun</div>
          <div class="calendar-date">Mon</div>
          <div class="calendar-date">Tue</div>
          <div class="calendar-date">Wed</div>
          <div class="calendar-date">Thu</div>
          <div class="calendar-date">Fri</div>
          <div class="calendar-date">Sat</div>
        </div>
        <div class="calendar-body">
          <div v-for="(day, index) in calendarData" class="calendar-date" v-bind:class="{ 'is-disabled': day.isDisabled }">
            <button class="date-item" v-bind:class="{ 'is-today': day.isToday, 'is-danger': day.isActive }">

              {{ day.day }}
            </button>
          </div>
        </div>
      </div>
    </div>
  </span>
</template>

<script>
import axios from 'axios'
import JapaneseHolidays from 'japanese-holidays'
import { csrfToken } from 'rails-ujs'
axios.defaults.headers.common['X-CSRF-TOKEN'] = csrfToken()
import Modal from './Modal.vue'

export default {
  props: ['circuitId'],
  components: {
    Modal
  },
  data() {
    return {
      testTxt : 'テストです',
      isOpen : false,
      calendarData: [],
      currentYear: 0,
      currentMonth: 0,
      holidayList: [],
      transition_name: 'show-next',
      dateList: [1, 2],
      visible_content: 0,
    }
  },
  mounted: function() {
    const toDay = new Date();
    this.currentYear = toDay.getFullYear()
    this.currentMonth = toDay.getMonth()+1
    this.calendarData = get_month_calendar(this.currentYear, this.currentMonth)
  },

  methods: {
    openModal : function(){
      this.isOpen = true;
    },
    closeModal : function(){
      this.isOpen = false;
    },
    next: function() {
      if (this.currentMonth == 12) {
        this.currentMonth = 1
        this.currentYear++
      } else {
        this.currentMonth++
      }
      this.calendarData = get_month_calendar(this.currentYear, this.currentMonth)
    },
    prev: function() {
      if (this.currentMonth == 1) {
        this.currentMonth = 12
        this.currentYear--
      } else {
        this.currentMonth--
      }
      this.calendarData = get_month_calendar(this.currentYear, this.currentMonth)
    },
    showPlan: function() {


    },
    getAttendance: async function(date, index) {
      const res = await axios.get(`/api/plans/?off_road_circuit_id=${this.circuitId}&date=${date}`)
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
      const res = await axios.post(`/api/plans/`, {date: date, off_road_circuit_id: this.circuitId })
      if (res.status !== 200) {
        console.log("Error!!")
        process.exit()
      }
      this.getAttendance(date, index)
    },

    deleteAttendance: async function(date, index) {
      const res = await axios.delete(`/api/plans/${this.holidayList[index].planId}`)
      if (res.status !== 200) {
        console.log("Error!!")
        process.exit()
      }
      this.getAttendance(date, index)
    },
  }
}
function get_month_calendar(year, month) {
  const today = new Date()
  const firstDate = new Date(year, (month - 1), 1); // 指定した年月の初日の情報
  const lastDay = new Date(year, (firstDate.getMonth() + 1), 0).getDate(); // 指定した年月の末日
  const weekday = firstDate.getDay(); // 指定した年月の初日の曜日

  let calendarData = []; // カレンダーの情報を格納
  let weekdayCount = weekday; // 曜日のカウント用
  const currentLastDay = new Date(year, (firstDate.getMonth()), 0).getDate()
  for (let i = 0; i < weekdayCount; i++) {
    calendarData.push(
      {
        day: currentLastDay - weekdayCount + i + 1,
        idToday: false,
        isDisabled: true,
        weekdayCount: weekdayCount,
        isActive: false
      }
    )
  }
  for (let i = 0; i < lastDay; i++) {
    calendarData.push(
      {
        day: i + 1,
        isToday: today.getDate() == i+1 ? true : false,
        isDisabled: false,
        weekdayCount: weekdayCount,
        isActive: (weekdayCount == 0 || weekdayCount == 6) ? true : false
      }
    )
    // 曜日のカウントが6(土曜日)まできたら0(日曜日)に戻す
    if(weekdayCount >= 6) {
        weekdayCount = 0;
    } else {
        weekdayCount++;
    }
  }
  if (weekdayCount < 6 && weekdayCount != 0) {
    for (let i = 0; i <= 6-weekdayCount; i++) {
      calendarData.push(
        {
          day: i + 1,
          idToday: false,
          isDisabled: true,
          weekdayCount: weekdayCount
        }
      )
    }
  }
  console.log(calendarData)
  return calendarData
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

  border-bottom: 1px solid #dbdbdb;
  border-left: 1px solid #dbdbdb;
  border-right: 1px solid #dbdbdb;

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
