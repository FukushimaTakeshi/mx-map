import moment from 'moment';

export default {
  methods: {
    get_month_calendar: function(year, month) {
      let currentDate = moment([year, month -1]); // 現在選択中の日付
      let weekdayCount = currentDate.weekday(); // 指定した年月の初日の曜日 (0-6)

      const previousDate = moment([year, month -1, 1]).subtract(1, 'months'); // 現在選択中(引数)の前月日付
      const previousLastDay = previousDate.daysInMonth(); // 現在選択中(引数)月の前月の日数 = 末日

      let dateListOfCalendarRange = []; // 現在選択中カレンダーリスト(日単位)

      // カレンダー1行目の前月日付
      for (let i = 0; i < weekdayCount; i++) {
        dateListOfCalendarRange.push(
          {
            year: previousDate.year(),
            month: previousDate.month() + 1,
            day: previousLastDay - weekdayCount + i + 1,
            idToday: false,
            isDisabled: true,
            weekdayCount: weekdayCount,
            isActive: false
          }
        )
      }

      // 現在選択中月の日付
      const today = moment();
      const currentLastDay = moment([year, month -1, 1]).daysInMonth(); // 指定した年の月の日数 = 末日
      for (let i = 0; i < currentLastDay; i++) {
        dateListOfCalendarRange.push(
          {
            year: currentDate.year(),
            month: currentDate.month() + 1,
            day: i + 1,
            isToday: today.date() == i+1 ? true : false,
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

      // カレンダー最終行の翌月日付
      if (weekdayCount <= 6 && weekdayCount != 0) {
        // 翌月に進める
        currentDate.add(1, 'months')

        for (let i = 0; i <= 6-weekdayCount; i++) {
          dateListOfCalendarRange.push(
            {
              year: currentDate.year(),
              month: currentDate.month() + 1,
              day: i + 1,
              idToday: false,
              isDisabled: true,
              weekdayCount: weekdayCount,
              isActive: false
            }
          )
        }
      }
      return dateListOfCalendarRange
    }
  }
}
