#!/bin/bash
#
# Library set ASCII codepage testing script
#
# Copyright (c) 2009-2013, Joachim Metz <joachim.metz@gmail.com>
#
# Refer to AUTHORS for acknowledgements.
#
# This software is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This software is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with this software.  If not, see <http://www.gnu.org/licenses/>.
#

EXIT_SUCCESS=0;
EXIT_FAILURE=1;
EXIT_IGNORE=77;

LNK_TEST_SET_ASCII_CODEPAGE="lnk_test_set_ascii_codepage";

if ! test -x ${LNK_TEST_SET_ASCII_CODEPAGE};
then
	LNK_TEST_SET_ASCII_CODEPAGE="lnk_test_set_ascii_codepage.exe";
fi

if ! test -x ${LNK_TEST_SET_ASCII_CODEPAGE};
then
	echo "Missing executable: ${LNK_TEST_SET_ASCII_CODEPAGE}";

	exit ${EXIT_FAILURE};
fi

CODEPAGES="ascii windows-874 windows-932 windows-936 windows-949 windows-950 windows-1250 windows-1251 windows-1252 windows-1253 windows-1254 windows-1255 windows-1256 windows-1257 windows-1258";

for CODEPAGE in ${CODEPAGES};
do
	./${LNK_TEST_SET_ASCII_CODEPAGE} ${CODEPAGE};

	RESULT=$?;

	echo -n -e "Testing setting supported ASCII codepage: ${CODEPAGE}\t"

	if [[ ${RESULT} -ne 0 ]];
	then
		echo "(FAIL)";
	else
		echo "(PASS)";
	fi
	echo "";

	if [[ ${RESULT} -ne 0 ]];
	then
		exit ${EXIT_FAILURE};
	fi
done

CODEPAGES="iso-8859-1 iso-8859-2 iso-8859-3 iso-8859-4 iso-8859-5 iso-8859-6 iso-8859-7 iso-8859-8 iso-8859-9 iso-8859-10 iso-8859-11 iso-8859-13 iso-8859-14 iso-8859-15 iso-8859-16 koi8_r koi8_u";

for CODEPAGE in ${CODEPAGES};
do
	./${LNK_TEST_SET_ASCII_CODEPAGE} ${CODEPAGE};

	RESULT=$?;

	echo -n -e "Testing setting unsupported ASCII codepage: ${CODEPAGE}\t"

	if [[ ${RESULT} -eq 0 ]];
	then
		echo "(FAIL)";
	else
		echo "(PASS)";
	fi
	echo "";

	if [[ ${RESULT} -eq 0 ]];
	then
		exit ${EXIT_FAILURE};
	fi
done

exit ${EXIT_SUCCESS};

