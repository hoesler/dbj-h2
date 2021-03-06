dbj_skips_global <- c(
  "package_name",                         # Not an error: too restrictive
  "constructor_strict", "constructor",    # Not an error: too restrictive
  "stress_load.*",                        # Not an error: substitute in make_context does not substitute   
  "stale_result_warning",                 # TODO: Currently I have no simple solution how to keep track of results
  "data_time($|_.+)",                     # TODO: why should time be returned as character?
  "data_timestamp_utc($|_.+)",            # TODO: If we store timestamp as SQL TIMESTAMP we have to discard timezone information.
  "data_64_bit($|_.+)",                   # TODO: don't understand the rational behind this test
  "data_type_connection",                 # TODO: What should be the data type for structure(.(value), class = "unknown1")?
  "append_table_error",                   # TODO: append to non-existing table should only fail if create = FALSE
  "overwrite_table",                      # TODO: similar to truncate?
  "roundtrip_64_bit",                     # TODO: dbWriteTable does not support a field.types argument
  "roundtrip_timestamp",                  # TODO: How can I differentiate between POSIXct and POSIXlt?
  "read_only",                            # TODO: Create read only test context for this test

  "data_logical_int",                     # not an error, full support for boolean data type
  "data_logical_int_null_.*",             # not an error, full support for boolean data type
  "roundtrip_logical_int",                # not an error, full support for boolean data type
  
  "quote_identifier_not_vectorized",      # not an error rstats-db/DBI#24

  "column_info",                          # DBI tells me to return name, field.type, and data.type not "name" and "type"
  "bind($|_.+)",                          # dbBind is not unsupported

  NULL
)

DBItest::make_context(
	H2(),
	# DATABASE_TO_UPPER=FALSE is required because of https://github.com/rstats-db/DBItest/issues/64
	list(url = "mem:dbi-test;DATABASE_TO_UPPER=FALSE", user = 'sa'),
	tweaks = DBItest::tweaks(constructor_name = "driver"),
  name = "H2"
)

DBItest::test_all(skip = c(
	# Driver independent
	dbj_skips_global,

	# H2 specific
	"data_date($|_.+)",									# Not an error: date() function is undefined in H2.
	"data_timestamp_parens($|_.+)", 		# Not an error: datetime() is an unsupported function in H2
	"data_raw($|_.+)",									# Not an error: SELECT cast(1 as BLOB) is invalid sytax in H2	
	NULL
))