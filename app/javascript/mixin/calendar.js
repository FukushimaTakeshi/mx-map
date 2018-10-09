export default {
  methods: {
    get_month_calendar: function(year, month) {
      const today = new Date()
      const firstDate = new Date(year, (month - 1), 1); // 指定した年月の初日の情報
      const lastDay = new Date(year, (firstDate.getMonth() + 1), 0).getDate(); // 指定した年月の末日
      const weekday = firstDate.getDay(); // 指定した年月の初日の曜日

      let calendarData = []; // カレンダーの情報を格納
      let weekdayCount = weekday; // 曜日のカウント用
      const currentLastDay = new Date(year, (firstDate.getMonth()), 0).getDate()
      const currentMonth = new Date(year, (firstDate.getMonth()), 0).getMonth() + 1
      for (let i = 0; i < weekdayCount; i++) {
        calendarData.push(
          {
            month: currentMonth,
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
            month: today.getMonth() + 1,
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
              month: today.getMonth() + 2,
              day: i + 1,
              idToday: false,
              isDisabled: true,
              weekdayCount: weekdayCount,
              isActive: false
            }
          )
        }
      }
      return calendarData
    }
  }
}
