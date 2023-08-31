#!/bin/env bash

echo "Hello $USER!"

while [ true ]
do
	echo -e '\n\n------------------------------'
	echo '| Hyper Commander            |'
	echo '| 0: Exit                    |'
	echo '| 1: OS info                 |'
	echo '| 2: User info               |'
	echo '| 3: File and Dir operations |'
	echo '| 4: Find Executables        |'
	echo -e '------------------------------'

	read user_input
	echo -e "\n"

	case "$user_input" in
		0)
			echo "Farewell!"
			exit
			;;

			
		1)
			uname -s
			uname -n
			;;

			
		2)
			whoami
			;;

			
		3)
			while true
			do
				echo -e "\nThe list of files and directories:"
				arr=(*)
				for item in "${arr[@]}"; do
					if [[ -f "$item" ]]; then
						echo "F $item"
					elif [[ -d "$item" ]]; then
						echo "D $item"
					fi
				done

				echo -e "\n---------------------------------------------------"
				echo -e "| 0 Main menu | 'up' To parent | 'name' To select |"
				echo "---------------------------------------------------"
				read user_input_2

				case $user_input_2 in
					0)
						break
						;;

					"up")
						cd ..
						;;

					*)
						if [[ " ${arr[@]} " =~ " ${user_input_2} " ]]; then
							if [[ -f "$user_input_2" ]]; then
								while true
								do
									echo -e "\n---------------------------------------------------------------------"
									echo "| 0 Back | 1 Delete | 2 Rename | 3 Make writable | 4 Make read-only |"
									echo "---------------------------------------------------------------------"
									read user_input_3

									case $user_input_3 in
										0)
											break
											;;
										
										1)
											rm "$user_input_2"
											echo "$user_input_2 has been deleted."
											break
											;;

										2)
											echo "Enter the new file name:"
											read new_name
											mv "$user_input_2" "$new_name"
											echo "$user_input_2 has been renamed as $new_name"
											break
											;;

										3)
											chmod a=rw "$user_input_2"
											echo "Permissions have been updated."
											ls -l "$user_input_2"
											break
											;;

										4)
											chmod 664 "$user_input_2"
											echo "Permissions have been updated."
											ls -l "$user_input_2"
											break
											;;
									esac
								done
							else
								cd "$user_input_2"
							fi
						else
							echo "Invalid input!"
						fi
						;;
				esac
			done
			;;


		4)
			echo "Enter an executable name:"
			read user_input_4
			location=$(which $user_input_4)

			if [[ -n "$location" ]]; then
				echo -e "\nLocated in: $location"
				echo -e "\nEnter arguments:"
				read args
				output=$($user_input_4 "$args")
				echo "$output"
			else
				echo "The executable with that name does not exist!"
			fi
			;;


		*)
			echo -e "Invalid option!\n"
			;;
	esac
done

