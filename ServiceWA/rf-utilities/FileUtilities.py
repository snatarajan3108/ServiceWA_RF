# Python program to explain os.path.isfile() method

# importing os module
import os
import time

class FileUtils():

    # @staticmethod
    def archiveReport(msg, featureName):
        print(featureName)
        # Path
        reportPath = os.getcwd().replace("my-tests", "") + 'Reports\\'
        latestreportPath = reportPath + 'LatestRun'

        from time import strftime
        current_month = strftime('%B')
        # print (current_month)

        reporthMonthlyFolder = reportPath + current_month
        if(os.path.isdir(reporthMonthlyFolder) == True):
            print ("Monthly Folder exist.")
        else:
            print ("Monthly Folder don't exist.")
            os.mkdir(reporthMonthlyFolder)
            print ("Created Folder... " + reporthMonthlyFolder)

        milliseconds = int(round(time.time() * 1000))
        reportTargetFolder = reporthMonthlyFolder + "\\" + featureName + "_" + str(milliseconds)
        import shutil
        shutil.copytree(latestreportPath, reportTargetFolder)
        print("Archived the LatestRun reports to ~ " + reportTargetFolder)