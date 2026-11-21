# Project Roadmap

## Completed Before Roadmap was made
- [X] Search functionality
- [X] Autopull current timestamp
- [X] Exclude Common Instance IDs
- [X] Custom Event Filter function
- [X] hour parameter
- [X] day parameter
- [X] script rewrite

## Short-Term
- [ ] ~~Better structuring to reduce unnecessary functions from being read by the system when not needed~~
- [X] Output logs to file (Completed 10/26/26)
- [ ] Sort by newest to oldest
- [X] Exclude Informational logs (Completed 11/14/26)
- [X] Extra time parameters such as -week, -halfday, -6hours (Completed on 11/21/26)
- [ ] Functionality to output to terminal and log file
- [ ] Functionality to detect if log file already exists and to prompt to appened or overwrite
- [X] Logic Rewrite to better handle multiple filter parameters

## Medium-Term
- [ ] Help Parameter
- [ ] Script can pull from custom lognames
- [ ] Error Catching
- [ ] Append to file (dependant on implimentation of outputting logs)
- [ ] Specify ID to exclude
- [X] Improved logic for how the code handles the -day and -hour parameters

## Long-Term / Future Ideas
- [ ] Interactive Version
- [ ] Pull logs from certain timeframes on certain days of the week

## Under-Consideration
- [ ] Prefab log file paths
- [ ] Logic rewrite such that logs are always ran through filter
- [ ] Extra script to automatically refrence microsoft documentation for each log
-- NOTE: Intended for background usage such as a highly filtered run of the script pulling logs for the entire week
