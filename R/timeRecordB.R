#'A function to record the time used in long time calculation.
#'
#'This function record the current time of when the function is used, and write that information into a txt file.
#'
#'
#'An global variable is generated in the session,
#'if this variable does not exist in the current R session. Then the output_message and the current time is written to a
#'file with the name that contains the current time. This function does not allow to to specify
#'the current time on purpose, but if you want to continue to append to one log file, you could assign the variable
#'with the file name in the global environment.
#'
#'@param  output_message A string that contains the message you want to saved.
#'
#'
#'@return NULL
#'
#'@examples
#'timeRecordB()
#'sum(1:10)
#'timeRecordB(output_message="sum from 1 to 10")
#'
#'extremely_long_name_i_do_not_think_anyone_would_be_sanely_to_use="logfile_names_to_append.log"
#'timeRecordB()
#'sum(1:10)
#'timeRecordB(output_message="sum from 1 to 10")
#'
#'
#'
#'@export

timeRecordB=function(output_message="None"){


  # append to file the current time if the file is already there.
  if(base::exists("extremely_long_name_i_do_not_think_anyone_would_be_sanely_to_use")){

    file_name=extremely_long_name_i_do_not_think_anyone_would_be_sanely_to_use

    base::write(c(output_message,proc.time()),ncolumns = 6 ,file=file_name,append=TRUE,sep=",")
  }else{
    # change file name into a legit file name on both windows 10 and ubuntu 16.04
    file_name=base::paste(format(Sys.time(), "%F_%T"),".log",sep="")
    file_name=base::gsub(":","_",x=file_name)
    file_name=base::gsub("-","_",x=file_name)


    base::file.create(file_name)
    # make the insanely long name a global variable
    extremely_long_name_i_do_not_think_anyone_would_be_sanely_to_use<<-file_name

    time_variable=c(output_message,base::proc.time())

    base::write(time_variable,file=file_name,ncolumns = 6 ,append=TRUE,sep=",")
    if(base::file.exists(file_name)){

      print("Fun time log has been created")

    }else{
      print("unsuccessful in creating a time log file")
    }
  }
}

