' Write one 40x24 screen plane as numbered Aquarius BASIC DATA statements.
' Build each complete line before PRINT so a pair cannot end an unnumbered line.
sub write_aq_data(byval output_file as integer, plane() as integer, byref next_line as integer, byval pairs_per_line as integer)
    dim cell_index as integer = 1
    dim run_value as integer
    dim run_length as integer
    dim pair_count as integer = 0
    dim data_line as string

    while cell_index <= 960
        run_value = plane(cell_index)
        run_length = 1
        while cell_index + run_length <= 960
            if plane(cell_index + run_length) <> run_value then exit while
            run_length = run_length + 1
        wend

        if pair_count = 0 then
            data_line = ltrim(str(next_line)) + " DATA "
        else
            data_line = data_line + ","
        end if
        data_line = data_line + ltrim(str(run_value)) + "," + ltrim(str(run_length))
        pair_count = pair_count + 1
        if pair_count = pairs_per_line then
            print #output_file, data_line
            next_line = next_line + 1
            pair_count = 0
        end if
        cell_index = cell_index + run_length
    wend

    ' Every plane ends with a sentinel pair, including at a full-line boundary.
    if pair_count = 0 then
        data_line = ltrim(str(next_line)) + " DATA "
    else
        data_line = data_line + ","
    end if
    print #output_file, data_line + "999,999"
    next_line = next_line + 1
end sub
