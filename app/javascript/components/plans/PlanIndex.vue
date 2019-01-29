<template>
  <span class="plan">
    <div class="calendar">
      <div class="calendar-nav">
        <div @click="prev()" class="calendar-nav-previous-month">
          <button class="button is-small is-text">
            <svg viewBox="0 0 50 80" xml:space="preserve">
              <polyline fill="none" stroke-width=".5em" stroke-linecap="round" stroke-linejoin="round" points="45.63,75.8 0.375,38.087 45.63,0.375 "></polyline>
            </svg>
          </button>
        </div>
        <div class="calendar-month">{{ currentYear }}年{{ currentMonth }}月</div>
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
          <div class="calendar-date" style="color:#FA6964;">Sun</div>
          <div class="calendar-date">Mon</div>
          <div class="calendar-date">Tue</div>
          <div class="calendar-date">Wed</div>
          <div class="calendar-date">Thu</div>
          <div class="calendar-date">Fri</div>
          <div class="calendar-date" style="color:#4987F2;">Sat</div>
        </div>
        <div class="calendar-body">
          <div v-for="(day, index) in calendarData" class="calendar-date" v-bind:class="{ 'is-disabled': day.isDisabled }">
            <button @click="openModal(day.day)" class="date-item" v-bind:class="{ 'is-today': day.isToday, 'is-danger': day.isActive }">
              {{ day.day }}
            </button>
          </div>
          <!-- modal component -->
          <Modal :circuit-id="circuitId" :user-id="userId"></Modal>
        </div>
      </div>
    </div>
  </span>
</template>

<script>
import Modal from './Modal.vue'
import ModalEvent from '../../packs/off_road_circuits/form.js'

export default {
  props: [
    'circuitId',
    'userId'
  ],
  components: {
    Modal
  },
  data() {
    return {
      isOpen : false,
      calendarData: [],
      currentYear: 0,
      currentMonth: 0
    }
  },
  mounted: function() {
    const toDay = new Date();
    this.currentYear = toDay.getFullYear()
    this.currentMonth = toDay.getMonth()+1
    this.calendarData = this.get_month_calendar(this.currentYear, this.currentMonth)
  },

  methods: {
    openModal: function(day){
      const date = `${this.currentYear}-${this.currentMonth}-${day}`
      ModalEvent.$emit('open-modal', date)
    },
    next: function() {
      if (this.currentMonth == 12) {
        this.currentMonth = 1
        this.currentYear++
      } else {
        this.currentMonth++
      }
      this.calendarData = this.get_month_calendar(this.currentYear, this.currentMonth)
    },
    prev: function() {
      if (this.currentMonth == 1) {
        this.currentMonth = 12
        this.currentYear--
      } else {
        this.currentMonth--
      }
      this.calendarData = this.get_month_calendar(this.currentYear, this.currentMonth)
    }
  }
}
</script>

<style lang="scss">
@import 'bulma-calendar/dist/css/bulma-calendar.min.css';

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

.calendar {
  max-width: initial;
}
</style>
