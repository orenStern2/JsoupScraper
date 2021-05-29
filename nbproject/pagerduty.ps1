# Backup from 29.05.21 

import pandas as pd
import numpy as np
import math
import warnings
from mishnah.mishnah_app.halukaMishnahyot_functions import *

# Requirements.txt:
# Package         Version
# --------------- -------------------
# argon2-cffi     20.1.0
# asgiref         3.3.1
# bcrypt          3.2.0
# cached-property 1.5.2
# certifi         2020.6.20
# certifi         2020.6.20
# cffi            1.14.5
# convertdate     2.3.2
# Django          3.1.6
# Faker           6.4.1
# future          0.18.2
# hbcal           0.11.0
# numpy           1.20.2
# pandas          1.2.4
# Pillow          8.2.0
# pip             20.2.3
# psycopg2        2.8.6
# pycparser       2.20
# pyluach         1.2.1
# PyMeeus         0.5.11
# PyQt5           5.15.0
# PyQtWebEngine   5.15.0
# python-bidi     0.4.2
# python-dateutil 2.8.1
# pytz            2020.1
# pywin32         228
# setuptools      50.3.2.post20201105
# six             1.15.0
# sqlparse        0.4.1
# text-unidecode  1.3
# wheel           0.35.1
# wincertstore    0.2


#def haluka_generator(mishnayot_count):

# git commit . -m "19.05.2021"
# pushing to git
# git push -u origin master

pd.options.mode.chained_assignment = None
# supress future warning(due to bug in numpy)
warnings.simplefilter(action='ignore', category=FutureWarning)

# import siddur_list CSV file
siddur_list = pd.read_csv(
    r'C:\Users\orenst\Google Drive\python\Udemy\Python and Django Full stack Web Developer Bootcamp\Course 010 - DJANGO\Django 02 - first project\My_Django_stuff\mishnah\static\mishnahyot.csv',
    encoding="ISO-8859-8")


# ==================================== adding mshnt_list to siddur_list ===============================================

n = 0
info = []
result = []
flag = False
flag_stand_alone_chapter = False
tractate_flag_once = False

# ========================================  Create mshnt_list numpy array ==============================================

while n <= siddur_df_num_of_rows(siddur_list):
    try:
        mshnt_count_in_row = create_mishnahyot_np_array(siddur_list['mshnt'][n])
        result.append(mshnt_count_in_row)
        #haluka_df['mshnt_list'][n] =  [mshnt_count_in_row]
    except:
        print("fail to append to result, line 23-24")
    n = n + 1

siddur_list['mshnt_list'] = list(result)


# ===========================================   start looping N ========================================================

n = 0
haluka_df_row = 0
mshnt_per_day = 25 # mishnayot_count


haluka_df_index = create_mishnahyot_np_array(math.ceil(4192/mshnt_per_day))



haluka_df = pd.DataFrame(index=[haluka_df_index])
haluka_df['סידור'] = 'None'
haluka_df['מסכת'] = 'None'
haluka_df['פרק'] = 'None'
haluka_df['משניות'] = 'None'
siddur_list['chapter_from_past'] = None

tarctate_to_merdge = False

keep_tractate_from_end_of_N_loop = False

while n <= siddur_df_num_of_rows(siddur_list):
    flag=False
    tractate_compare = 'False'


    print('start N looping, loop number:', n)
    # =============================================  1 =================================================================


    # if mshnt_left and mshnt_list empty then break
    try:
        if isnumpyempty(siddur_list['mshnt_list'][n]):
            print('mshnt_list in line '+str(n)+' is empty n=n+1 (script line 41')
            n = n + 1
            #break
    except:
        if siddur_list['mshnt_list'][n] == '':
            print('mshnt_list in line '+str(n)+' is empty n=n+1 (script line 41')
            n = n + 1
            #break

    #
    #
    #     # if mshnt_left has numbers
    #     if siddur_list['mshnt_left'][n] != 'None':
    #         mshnt_left_np_array = siddur_list['mshnt_left'][n]


    # =============================================  2 =================================================================


    # check if column mshnt_list in siddur_list holds numbers
    if not isnumpyempty(siddur_list['mshnt_list'][n]):
        mshnt_list_np_array = siddur_list['mshnt_list'][n]

        print('line 81',mshnt_list_np_array)

        print('line 80: is mshnt_list < mshnt_per_day:', get_mishnahot_np_array_from_df(siddur_list,'mshnt_list',n).size < mshnt_per_day and check_if_last_loop(n+1, siddur_list)==False)
        # =====================================  2a mshnt_list < =======================================================
        counter = 1

        while get_mishnahot_np_array_from_df(siddur_list,'mshnt_list',n).size < mshnt_per_day and check_if_last_loop(n+1, siddur_list)==False:

            if check_if_last_loop(n+1, siddur_list)==True:

                mshnt_list_np_array = siddur_list['mshnt_list'][n]
                mshnt_merdge = siddur_list['mshnt_list'][n]
                mshnt_merdge = np.concatenate(([siddur_list['mshnt_list'][n], siddur_list['mshnt_list'][n]]), axis=None)
                siddur_list['mshnt_list'][n] = mshnt_merdge


            else:

                print('while < counter =', counter)

                print('n before +1',n)
                mshnt_list_np_array = siddur_list['mshnt_list'][n]
                mshnt_merdge = siddur_list['mshnt_list'][n]

                if siddur_list['chapter_from_past'][n]:
                    #flag_stand_alone_chapter = True
                    chptr_merdge = siddur_list['chapter_from_past'][n] + ' ' + siddur_list['chapter'][n]
                    print('line 117', chptr_merdge)
                elif isnumpyempty(siddur_list['mshnt_list'][n]):
                    #flag_stand_alone_chapter = True
                    chptr_merdge = siddur_list['chapter'][n+1]
                    print('line 122')
                else:
                    chptr_merdge = siddur_list['chapter'][n]

                    print('line 120', chptr_merdge)
                print('Chapter merdge 105: {} N: {}'.format(chptr_merdge,n))

                i = n
                while get_mishnahot_np_array_from_df(siddur_list,'mshnt_list',n).size < mshnt_per_day and check_if_last_loop(i+1, siddur_list)==False:
                    # check if cell holds numpy array (return True if string type)
                    if isinstance(siddur_list['mshnt_list'][i+1], str)==False:
                        print('line 133', siddur_list['mshnt_list'][i+1])

                        mshnt_merdge = np.concatenate(([siddur_list['mshnt_list'][n], siddur_list['mshnt_list'][i+1]]), axis=None)
                        siddur_list['mshnt_list'][i+1] = ''
                        siddur_list['mshnt_list'][n] = mshnt_merdge
                        print('in while', mshnt_merdge)

                        # chapter merdge

                        if flag_stand_alone_chapter:
                            chptr_merdge = chptr_merdge
                            print('line 144 - chptr merdge', chptr_merdge)
                        else:
                            if chptr_merdge == siddur_list['chapter'][i+1]:
                                chptr_merdge = siddur_list['chapter'][i+1]

                            else:
                                chptr_merdge = chptr_merdge +' '+ siddur_list['chapter'][i+1]
                                if n != check_if_last_loop(n, siddur_list):
                                    tarctate_to_merdge = siddur_list['tractate'][n-1]
                                    print('line 200')
                                print('line 192', tarctate_to_merdge)

                            print('line 147')
                        print('Chapter merdge 145: {} N: {}'.format(chptr_merdge,n))

                        if i == siddur_df_num_of_rows(siddur_list):
                            last_chapter_hold = siddur_list['chapter'][i]
                            print('last chapter hold', last_chapter_hold)

                        #siddur_list['chapter'][i+1] = 'None'

                        i = i + 1
                    else:
                        i=i+1
                print('mshnt_merdge', mshnt_merdge)
                print('159 i=', i)
                print('160 n=', n)
                n=i-1
                print('haluka:', haluka_df)

                siddur_list['mshnt_list'][n+1] = mshnt_merdge[mshnt_per_day:]
                print(siddur_list)
                print('how much in the array', siddur_list['mshnt_list'][n+1])

                # haluka_df append
                haluka_df['משניות'][haluka_df_row] = mshnt_merdge[:mshnt_per_day]
                print('chptr_merdge line 140', chptr_merdge)
                print('chapter in siddur_list', siddur_list )
                if n+1 == siddur_df_num_of_rows(siddur_list):
                    print('159')
                    if siddur_list['chapter_from_past'][n]:
                        print('161')
                        if flag_stand_alone_chapter:
                            haluka_df['פרק'][haluka_df_row] = chptr_merdge

                        else:
                            haluka_df['פרק'][haluka_df_row] = siddur_list['chapter_from_past'][n]
                            haluka_df['מסכת'][haluka_df_row]= siddur_list['tractate'][n]
                            print('177')
                    else:
                        if n == siddur_df_num_of_rows(siddur_list):
                            haluka_df['פרק'][haluka_df_row] = siddur_list['chapter'][n]
                            haluka_df['מסכת'][haluka_df_row]= siddur_list['tractate'][n]
                            print('line 173')
                        else:
                            if chptr_merdge:
                                print('187', siddur_list['chapter'][i])
                                if isinstance(siddur_list['chapter'][i], str)==False:
                                    print('line 185', siddur_list['chapter'][i])
                                    haluka_df['פרק'][haluka_df_row] = siddur_list['chapter'][i]
                                    haluka_df['מסכת'][haluka_df_row] = siddur_list['tractate'][i]
                                else:
                                    haluka_df['פרק'][haluka_df_row] = chptr_merdge
                                    haluka_df['מסכת'][haluka_df_row] = siddur_list['tractate'][i]

                            else:
                                haluka_df['פרק'][haluka_df_row] = siddur_list['chapter'][n+1]
                                haluka_df['מסכת'][haluka_df_row] = siddur_list['tractate'][n+1]

                            print('184', haluka_df['פרק'])
                    # print('line 166', haluka_df['פרק'][haluka_df_row])
                else:
                    if siddur_list['chapter_from_past'][n]:
                        if siddur_list['chapter_from_past'][n] in chptr_merdge and siddur_list['chapter'][n] in chptr_merdge:
                            haluka_df['פרק'][haluka_df_row] = chptr_merdge
                            if siddur_list['tractate'][i] != siddur_list['tractate'][i-1] and haluka_df['פרק'][haluka_df_row] in haluka_df['פרק'][haluka_df_row]: # it was in haluka_df['פרק'][haluka_df_row-1]
                                haluka_df['מסכת'][haluka_df_row] = siddur_list['tractate'][i-1] + ' ' +siddur_list['tractate'][i]
                                print('line 256', haluka_df['פרק'][haluka_df_row])
                            else:
                                haluka_df['מסכת'][haluka_df_row] = siddur_list['tractate'][i]
                                print('line 254', haluka_df['פרק'][haluka_df_row-1])
                        else:
                            print('169')
                            haluka_df['פרק'][haluka_df_row] = siddur_list['chapter_from_past'][n] + ' ' + siddur_list['chapter'][n]
                            haluka_df['מסכת'][haluka_df_row] = siddur_list['tractate'][i]
                    else:
                        print('172', chptr_merdge)
                        haluka_df['פרק'][haluka_df_row] = chptr_merdge
                        haluka_df['מסכת'][haluka_df_row] = siddur_list['tractate'][i]
                        print('280', siddur_list['tractate'][i])
                        if n+1 != siddur_df_num_of_rows(siddur_list):
                            print('line 220 - i: {}, tractate in siddur: {}'.format(i, siddur_list['tractate'][i]))

                            if tractate_compare != siddur_list['tractate'][i] and tractate_compare != 'False' and 'א' not in chptr_merdge[0]:
                                haluka_df['מסכת'][haluka_df_row] =tractate_compare + ' ' + siddur_list['tractate'][i]
                                print('line 226', tractate_compare)
                            else:
                                haluka_df['פרק'][haluka_df_row] = chptr_merdge
                                if keep_tractate_from_end_of_N_loop and keep_tractate_from_end_of_N_loop != siddur_list['tractate'][i] and siddur_list['tractate'][i] != siddur_list['tractate'][i-1]:
                                    haluka_df['מסכת'][haluka_df_row] = keep_tractate_from_end_of_N_loop + ' ' + siddur_list['tractate'][i]
                                    keep_tractate_from_end_of_N_loop = False
                                else:
                                    haluka_df['מסכת'][haluka_df_row] = siddur_list['tractate'][i]
                                print('line 230', siddur_list['tractate'][i] )
                            tractate_compare = siddur_list['tractate'][i]
                            #siddur_list['chapter_from_past'][i-] = chptr_merdge[len(chptr_merdge)-1:]
                            print('line 193', tractate_compare)

                        else:
                            siddur_list['chapter_from_past'][n+1] = chptr_merdge[len(chptr_merdge)-1:]
                        print('line 188',siddur_list['chapter_from_past'][n+1])

                haluka_df_row = haluka_df_row+1
                n = n + 1

                #print('last_chapter_hold',last_chapter_hold)

                counter=counter+1



        if get_mishnahot_np_array_from_df(siddur_list,'mshnt_list', n).size < mshnt_per_day and check_if_last_loop(n+1, siddur_list)==True and isnumpyempty(siddur_list['mshnt_list'][n])==False:
            print('line 88', n)

            # haluka_df append

            haluka_df['משניות'][haluka_df_row] = siddur_list['mshnt_list'][n]

            #print("Line 203 - siddur_list['chapter'][n]", siddur_list['chapter'][haluka_df_row])
            print('n',n)

            haluka_df['פרק'][haluka_df_row] = siddur_list['chapter'][n]
            haluka_df['מסכת'][haluka_df_row] = siddur_list['tractate'][n]

            break


        # =====================================  2b mshnt_list > =======================================================
        # check if there's enough mishnahyot in chapter

        print('line 106: is mshnt_list > mshnt_per_day:', get_mishnahot_np_array_from_df(siddur_list,'mshnt_list',n).size > mshnt_per_day)
        tractate_flag_once = False
        print('line 269 - tarctate in siddur_list [n]: {}. tractate_flag_once: {}'.format(siddur_list['tractate'][n],tractate_flag_once))

        while get_mishnahot_np_array_from_df(siddur_list,'mshnt_list', n).size > mshnt_per_day:

            print('mshnt in while > {}.loop N number: {}.'.format(siddur_list['mshnt_list'][n], n))

            # cut off mshnt_per_day and write it to siddur_list['mshnt_list'][n]



            print('line 114',mshnt_list_np_array)

            # write mishnahyot taken to haluka dataframe ['mishnahyot']

            # haluka_df append
            print('line 231', siddur_list['chapter_from_past'][n])
            if siddur_list['chapter_from_past'][n]:
                haluka_df['פרק'][haluka_df_row] = siddur_list['chapter_from_past'][n] + ' ' + siddur_list['chapter'][n]
                siddur_list['chapter_from_past'][n] = None

                if  siddur_list['tractate'][n] not in haluka_df['מסכת'][haluka_df_row] and tractate_flag_once==False:
                    haluka_df['מסכת'][haluka_df_row] = siddur_list['tractate'][n-1]+ ' ' + siddur_list['tractate'][n]
                    tractate_flag_once = True
                    print("line 292 - haluka_df['מסכת'][haluka_df_row]: {}, siddur_list['tractate'][n]:{} ".format(haluka_df['מסכת'][haluka_df_row],len(siddur_list['tractate'][n])))
                    print('line 293 - chapter:',  haluka_df['פרק'][haluka_df_row])
                else:
                    haluka_df['מסכת'][haluka_df_row] = siddur_list['tractate'][n]

            else:
                print('line 261 add haluka_df chapters {} to line {} in haluka_df'.format(siddur_list['chapter'][n], haluka_df_row))
                haluka_df['פרק'][haluka_df_row] = siddur_list['chapter'][n]
                haluka_df['מסכת'][haluka_df_row] = siddur_list['tractate'][n]

            print(haluka_df)

            haluka_df['משניות'][haluka_df_row] = siddur_list['mshnt_list'][n][:mshnt_per_day]
            haluka_df_row = haluka_df_row+1
            siddur_list['mshnt_list'][n] = siddur_list['mshnt_list'][n][mshnt_per_day:]

            print('line 123',siddur_list['mshnt_list'][n])


            print('result of line 248:', get_mishnahot_np_array_from_df(siddur_list,'mshnt_list',n).size < mshnt_per_day and check_if_last_loop(n+1, siddur_list)==False)

            print("siddur_list['mshnt_list'][n]", siddur_list['mshnt_list'][n])

            if get_mishnahot_np_array_from_df(siddur_list,'mshnt_list',n).size < mshnt_per_day and check_if_last_loop(n+1, siddur_list)==False:

                print('mshnt in while > {}.loop N number: {}.'.format(siddur_list['mshnt_list'][n+1], n))

                temp_left_over = siddur_list['mshnt_list'][n]
                try:
                    while isnumpyempty(siddur_list['mshnt_list'][n+1]):
                        print('line 204')
                        n=n+1
                except:
                    while siddur_list['mshnt_list'][n+1] == '':
                        print('line 208')
                        n=n+1

                mshnt_merdge = np.concatenate(([temp_left_over, siddur_list['mshnt_list'][n+1]]), axis=None)

                siddur_list['mshnt_list'][n+1] = mshnt_merdge


                # get the last string from current N and pass it to N+1

                if len(siddur_list['chapter'][n])==2:
                    print('337', siddur_list['chapter'][n])
                    siddur_list['chapter_from_past'][n+1] = siddur_list['chapter'][n]
                    print('339', siddur_list['chapter_from_past'][n+1] )
                else:
                    siddur_list['chapter_from_past'][n+1] = siddur_list['chapter'][n][len(siddur_list['chapter'][n])-1]

                print('line 234', siddur_list['chapter_from_past'][n+1])
                print('line 299 - haluka_df row number: ', haluka_df_row)




                #
                # print('line 221', mshnt_merdge)
                # print('mshnt_merdge', mshnt_merdge[mshnt_per_day:])
                # print('n=', n)
                # siddur_list['mshnt_list'][n+1] = mshnt_merdge[mshnt_per_day:]
                #
                # # haluka_df append
                # haluka_df['פרק'][haluka_df_row] = siddur_list['chapter'][n]
                # haluka_df['משניות'][haluka_df_row] = mshnt_merdge[:mshnt_per_day]
                #haluka_df_row = haluka_df_row+1
                flag = True
                break
                #n = n + 1

            print('result of line 237:', get_mishnahot_np_array_from_df(siddur_list,'mshnt_list',n).size < mshnt_per_day and check_if_last_loop(n+1, siddur_list)==True)
            if get_mishnahot_np_array_from_df(siddur_list,'mshnt_list',n).size < mshnt_per_day and check_if_last_loop(n+1, siddur_list)==True:

                print('break after adding in line 142', siddur_list['mshnt_list'][n])

                # haluka_df append
                print('line 323 adding chapter:', siddur_list['chapter'][n])
                haluka_df['מסכת'][haluka_df_row] = siddur_list['tractate'][n]
                haluka_df['פרק'][haluka_df_row] = siddur_list['chapter'][n]
                haluka_df['משניות'][haluka_df_row] = siddur_list['mshnt_list'][n]
                break

        keep_tractate_from_end_of_N_loop = False
        # =====================================  2c mshnt_list == ======================================================
        if flag == False:
            print('line 145: is mshnt_list == mshnt_per_day (and not last N):',  get_mishnahot_np_array_from_df(siddur_list,'mshnt_list',n).size == mshnt_per_day and check_if_last_loop(n, siddur_list)==False)

            if get_mishnahot_np_array_from_df(siddur_list,'mshnt_list',n).size == mshnt_per_day and check_if_last_loop(n, siddur_list)==False:

                # haluka_df append
                print('line 261 adding chapter:', siddur_list['chapter'][n])
                print('line 385', siddur_list['chapter_from_past'][n])

                if siddur_list['chapter_from_past'][n] and siddur_list['tractate'][n-1] != siddur_list['tractate'][n]:     ######################  when mishnayot 6 - line 26 in CSV need to be fixed
                    haluka_df['מסכת'][haluka_df_row] = siddur_list['tractate'][n-1] + ' ' + siddur_list['tractate'][n]
                    haluka_df['פרק'][haluka_df_row] = siddur_list['chapter_from_past'][n] + ' ' + siddur_list['chapter'][n]
                    print('line 392 - tractate:', haluka_df['מסכת'][haluka_df_row])
                elif siddur_list['chapter_from_past'][n] and siddur_list['tractate'][n-1] == siddur_list['tractate'][n]:
                    haluka_df['פרק'][haluka_df_row] = siddur_list['chapter_from_past'][n] + ' ' + siddur_list['chapter'][n]
                    haluka_df['מסכת'][haluka_df_row] = siddur_list['tractate'][n]
                    print('line 395 - tractate:', haluka_df['פרק'][haluka_df_row])

                else:
                    haluka_df['מסכת'][haluka_df_row] = siddur_list['tractate'][n]

                    keep_tractate_from_end_of_N_loop = siddur_list['tractate'][n]
                    haluka_df['פרק'][haluka_df_row] = siddur_list['chapter'][n]
                haluka_df['משניות'][haluka_df_row] = siddur_list['mshnt_list'][n]
                haluka_df_row = haluka_df_row + 1
                n = n + 1
                continue




            elif get_mishnahot_np_array_from_df(siddur_list,'mshnt_list',n).size == mshnt_per_day and check_if_last_loop(n, siddur_list)==True:

                # haluka_df append
                print('line 273 adding chapter:', siddur_list['chapter'][n])
                haluka_df['פרק'][haluka_df_row] = siddur_list['chapter'][n]
                haluka_df['פרק'][haluka_df_row] = siddur_list['chapter'][n]
                haluka_df['משניות'][haluka_df_row] = siddur_list['mshnt_list'][n]


    n = n + 1

    print('end looping, n ==', n)


# droping empty numpy array haluka_df
haluka_df = haluka_df.loc[haluka_df['משניות'] != 'None']

for index, row in haluka_df.iterrows():
    try:
        if isnumpyempty(haluka_df.mishnahyot[index]):
            haluka_df.drop(labels=index,axis=0,inplace=True)
    except:
        if haluka_df['משניות'][index] == 'None':
            haluka_df.drop(labels=index,axis=0,inplace=True)



#haluka_df['משניות'] = np.where((isnumpyempty(haluka_df.mishnahyot)),None,haluka_df.mishnahyot)


zeraim = ["ברכות","פאה","דמאי","כלאיים","שביעית","תרומות","מעשרות","מעשר שני","חלה","ערלה","ביכורים"]
moed = ["שבת", "עירובין","פסחים","שקלים","יומא","סוכה","ביצה","ראש השנה","תענית","מגילה","מועד קטן","חגיגה"]
for i, row in haluka_df.iterrows():

    first_tractate = row[1].split(' ')[0]
    if "מעשר שני" in row[1]:
        row['סידור'] = 'זרעים '

    elif first_tractate in zeraim:
        row['סידור'] = 'זרעים '


        # try:
        #     print('row 0', row[0].split(' ')[0])
        #     print('row 1:',row[0].split(' ')[1])
        # except:
        #     err = 'error'



print(siddur_list['tractate'])
print(haluka_df)


# convert haluka_df to CSV
haluka_df.to_csv(
    r'C:\Users\orenst\Google Drive\python\Udemy\Python and Django Full stack Web Developer Bootcamp\Course 010 - DJANGO\Django 02 - first project\My_Django_stuff\mishnah\static\haluka_df.csv',
    encoding="ISO-8859-8")
