
macro(em_expand CONTEXT_FILE_IN CONTEXT_FILE_OUT EM_FILE_IN CMAKE_FILE_OUT)
  assert_file_exists("${CONTEXT_FILE_IN}" "empy input file")
  configure_file(${CONTEXT_FILE_IN} ${CONTEXT_FILE_OUT})
  log(2 "Expanding ${EM_FILE_IN} from ${CONTEXT_FILE_OUT}")

  assert_file_exists("${CONTEXT_FILE_OUT}" "CONTEXT_FILE_OUT")
  assert_file_exists("${CATKIN_CONTEXT_FILE}" "CATKIN_CONTEXT_FILE")
  assert_file_exists(${catkin_EXTRAS_DIR}/empy_util.py "empy utilities")

  stamp(${EM_FILE_IN})

  safe_execute_process(COMMAND
    ${EMPY_EXECUTABLE}
    --raw-errors
    -F ${catkin_EXTRAS_DIR}/empy_util.py
    -F ${CONTEXT_FILE_OUT}
    -F ${CATKIN_CONTEXT_FILE}
    -o ${CMAKE_FILE_OUT}
    ${EM_FILE_IN}
    )
  log(2 STATUS "*** including ${CMAKE_FILE_OUT}")
  include(${CMAKE_FILE_OUT})
endmacro()
