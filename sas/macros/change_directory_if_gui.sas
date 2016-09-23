 /*----------------------------------------------------------------------------
If run from a GUI (not batch), changes the system's working directory to that
of the program. Afterwards, file paths can be written relative to the new
directory.
 ----------------------------------------------------------------------------*/
%MACRO change_directory_if_gui;
        %Let execpath = %sysget(SAS_EXECFILEPATH);
        %If %length(&execpath.) > 0 %then %do;
                %Let execname = %sysget(SAS_EXECFILENAME);
                %Let execdir_length = %eval(%length(&execpath.) - %length(&execname.) - 1);
                %Let execdir = %substr(&execpath., 1, &execdir_length.);
                DATA _NULL_;
                        rc = system("cd ""&execdir.""");
                Run;
        %End;
%Mend change_directory_if_gui;
