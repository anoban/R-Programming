strptime("12-12-2022", format = "%d-%m-%Y")
strptime("12-12-2022 14:45:48", format = "%d-%m-%Y %H:%M:%S")

strptime("12-12-2022 14:45:48", format = "%d-%m-%Y %H:%M:%S") |>
    months()

strptime("12-12-2022 14:45:48", format = "%d-%m-%Y %H:%M:%S") |>
    weekdays()

strptime("12-12-2022 14:45:48", format = "%d-%m-%Y %H:%M:%S") |>
    weekdays.Date()

strptime("12-12-2022 14:45:48", format = "%d-%m-%Y %H:%M:%S") |>
    weekdays.POSIXt()

strptime("12-12-2022 14:45:48", format = "%d-%m-%Y %H:%M:%S") |>
    class()

as.Date("2022-12-12") |> class()

# POSIX date representation -> similar to Excel
# 01-10-1970 represented by 0
# dates are represented by Date class
# as number of days since 01-01-1970
# times are represented by 2 separate classes: POSIXct & POSIXlt
# as number of seconds since 01-01-1970
# POSIXct is a numerical representation, just one big integer, similar to the way Excel stores dates
# POSIXlt stores each time as a list with associated information


"2015-07-27" |> as.Date() |> as.numeric()
"2015-07-27" |> as.Date() |> unclass()

seq(-365, 35000, by = 365) |> as.Date(origin = "1970-01-01")
seq(0, by = 60, length.out = 10000) |> as.POSIXct(origin = "1970-01-01")
seq(0, by = 3600, length.out = 10000) |> as.POSIXct(origin = "1970-01-01")
seq(0, by = 3600*24, length.out = 10000) |> as.POSIXct(origin = "1970-01-01")
seq(0, by = 3600*24*365, length.out = 100) |> as.POSIXct(origin = "1970-01-01")

# POSIXlt is less memory efficient compared to POSIXct

Sys.Date()
Sys.time()
Sys.timezone()

Sys.time() |> as.POSIXlt()
Sys.time() |> as.POSIXlt() |> unclass()
Sys.time() |> as.POSIXlt() |> unclass() |> names()
Sys.time() |> as.POSIXlt() |> unclass() |> unlist()

Sys.time() |> unclass()
posix <- Sys.Date() |> unclass()  

{posix - {52 * 365}} |> as.Date(origin = "2022-01-01")

strptime("12-December-1997 07:45:56 AM", format = "%d-%B-%Y %I:%M:%S %p")

# Date, POSIXct & POSIXlt objects support arithmetics
# plotting functions has native support for Date & POSIX classes
