#'A function to read the time record in the timeRecordB function.
#'
#'This function read the time record from the log file created by timeRecordB.
#'
#'
#'Given the current global variable extremely_long_name_i_do_not_think_anyone_would_be_sanely_to_use,
#'timeRecordR function would try to read in the log file, then time interval is calculated for each recorded time.
#'
#'
#'@param  unit A character. The unit for the time.
#'@param ignore A numeric. The minimal time interval to include.
#'
#'@return dataframe for the recorded time intervals with output message .
#'
#'@examples
#'
#'timeRecordR()
#'
#'
#'library(dplyr)
#'timeRecordR()%>%filter(output_message!="None")%>%select(output_message,run_time)
#'
#'@import magrittr
#'@importFrom dplyr filter
#'
#'
#'
#'@export

timeRecordR=function(unit="s",ignore=1){

  # If the file needed to read is there. Then, we could began to read it into R.
  if(base::file.exists(extremely_long_name_i_do_not_think_anyone_would_be_sanely_to_use)){

    time_dataframe=utils::read.table(extremely_long_name_i_do_not_think_anyone_would_be_sanely_to_use,sep=",")

    base::colnames(time_dataframe)=c("output_message",base::names(base::proc.time()) )


    time_interval=c(0,base::diff(time_dataframe[,"elapsed"]))

    # for different time unit, we will give values for differnt run_time.
    switch(unit,
           s={time_dataframe=cbind(time_dataframe,run_time=time_interval)}
           ,min={time_dataframe=cbind(time_dataframe,run_time=time_interval/60)}
           ,hr={time_dataframe=cbind(time_dataframe,run_time=time_interval/3600)} )

    time_dataframe=time_dataframe%>%dplyr::filter(run_time>ignore)


  }else{
    print("Please use function timeRecordB to create a log file first.")
  }

  return(time_dataframe)

}
