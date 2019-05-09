%Grade 10 Computer Science Final Project
%Tanky Troubles (TM)
%A fun two-player tank game
%Parth Baraliya, Gregory Shaikevich, Bill Wu
%June 13, 2016

setscreen ("graphics:1000;750")

%Tank images and sprites for all directions
var tankRedN, tankGreenN, tankRedE, tankGreenE, tankRedS, tankGreenS, tankRedW, tankGreenW : int
var spriteTankRedN, spriteTankGreenN, spriteTankRedE, spriteTankGreenE, spriteTankRedS, spriteTankGreenS, spriteTankRedW, spriteTankGreenW : int

%Background image of the maze and the winning screens
var background : int := Pic.FileNew ("maze.bmp")
var winOne : int := Pic.FileNew ("WINONE.bmp")
var winTwo : int := Pic.FileNew ("WINTWO.bmp")

winOne := Pic.Scale (winOne, 1000, 750)
winTwo := Pic.Scale (winTwo, 1000, 750)

%Tank coordinates and directions faced
var tankRedX : int
var tankRedY : int
var tankGreenX : int
var tankGreenY : int
var dirRed, dirGreen : int := 3

%Bullet image and sprites
var bullet : int
var spriteBulletRed : int
var spriteBulletGreen : int

%Bullet coordinates
var redBulletX := 0
var redBulletY := 0
var greenBulletX := 0
var greenBulletY := 0

% Bullet move code and variables
bullet := Pic.FileNew ("bullet.jpg")
bullet := Pic.Scale (bullet, 5, 5)
spriteBulletRed := Sprite.New (bullet)
spriteBulletGreen := Sprite.New (bullet)

%Music played during game - "Spanish Flea"
Music.PlayFileLoop ("Game Music.mp3")

%Process for the controls/actions of the red tank
process tankRedMove
    var chars : array char of boolean
    loop
	Input.KeyDown (chars)
	%Moves tank up/north
	if chars (KEY_UP_ARROW) then
	    %Checks for walls
	    if whatdotcolour (tankRedX, tankRedY + 17) = 30 and whatdotcolour (tankRedX - 10, tankRedY + 17) = 30 and whatdotcolour (tankRedX + 10, tankRedY + 17) = 30
		    and whatdotcolour (tankRedX - 5, tankRedY + 17) = 30 and whatdotcolour (tankRedX + 5, tankRedY + 17) = 30 then
		%Shows and hides required sprites
		Sprite.Show (spriteTankRedN)
		Sprite.Hide (spriteTankRedE)
		Sprite.Hide (spriteTankRedS)
		Sprite.Hide (spriteTankRedW)
		%Moves tank north by one
		Sprite.SetPosition (spriteTankRedN, tankRedX, tankRedY + 1, true)
		tankRedY := tankRedY + 1
		redBulletY := tankRedY
		dirRed := 1
		delay (8)
	    end if
	    %Moves tank down/south
	elsif chars (KEY_DOWN_ARROW) then
	    %Checks for walls
	    if whatdotcolour (tankRedX, tankRedY - 17) = 30 and whatdotcolour (tankRedX - 10, tankRedY - 17) = 30 and whatdotcolour (tankRedX + 10, tankRedY - 17) = 30
		    and whatdotcolour (tankRedX - 5, tankRedY - 17) = 30 and whatdotcolour (tankRedX + 5, tankRedY - 17) = 30 then
		%Shows and hides required sprites
		Sprite.Show (spriteTankRedS)
		Sprite.Hide (spriteTankRedN)
		Sprite.Hide (spriteTankRedE)
		Sprite.Hide (spriteTankRedW)
		%Moves tank south by one
		Sprite.SetPosition (spriteTankRedS, tankRedX, tankRedY - 1, true)
		tankRedY := tankRedY - 1
		redBulletY := tankRedY
		dirRed := 3
		delay (8)
	    end if
	    %Moves tank left/west
	elsif chars (KEY_LEFT_ARROW) then
	    %Checks for walls
	    if whatdotcolour (tankRedX - 17, tankRedY) = 30 and whatdotcolour (tankRedX - 17, tankRedY - 10) = 30 and whatdotcolour (tankRedX - 17, tankRedY + 10) = 30
		    and whatdotcolour (tankRedX - 17, tankRedY + 5) = 30 and whatdotcolour (tankRedX - 17, tankRedY - 5) = 30 then
		%Shows and hides required sprites
		Sprite.Show (spriteTankRedW)
		Sprite.Hide (spriteTankRedN)
		Sprite.Hide (spriteTankRedE)
		Sprite.Hide (spriteTankRedS)
		%Moves tank west by one
		Sprite.SetPosition (spriteTankRedW, tankRedX - 1, tankRedY, true)
		tankRedX := tankRedX - 1
		redBulletX := tankRedX
		dirRed := 4
		delay (8)
	    end if
	    %Moves tank right/east
	elsif chars (KEY_RIGHT_ARROW) then
	    %Checks for walls
	    if whatdotcolour (tankRedX + 17, tankRedY) = 30 and whatdotcolour (tankRedX + 17, tankRedY - 10) = 30 and whatdotcolour (tankRedX + 17, tankRedY + 10) = 30
		    and whatdotcolour (tankRedX + 17, tankRedY + 5) = 30 and whatdotcolour (tankRedX + 17, tankRedY - 5) = 30 then
		%Shows and hides required sprites
		Sprite.Show (spriteTankRedE)
		Sprite.Hide (spriteTankRedN)
		Sprite.Hide (spriteTankRedS)
		Sprite.Hide (spriteTankRedW)
		%Moves tank east by one
		Sprite.SetPosition (spriteTankRedE, tankRedX + 1, tankRedY, true)
		tankRedX := tankRedX + 1
		redBulletX := tankRedX
		dirRed := 2
		delay (8)
	    end if
	end if
	%Carries out the shooting action
	if chars ('0') then
	    %Determines the direction faced by the tank (north in this case)
	    if dirRed = 1 then
		%Sets bullet's coordinates
		redBulletY := tankRedY + 17
		loop
		    %Moves bullet north
		    Sprite.SetPosition (spriteBulletRed, tankRedX, redBulletY, true)
		    Sprite.Show (spriteBulletRed)
		    redBulletY := redBulletY + 1
		    %Checks for tank collision
		    exit when whatdotcolour (tankRedX, redBulletY) = 22 or ((tankGreenY - redBulletY) ** 2) + ((tankGreenX - redBulletX) ** 2) < 200
		    delay (4)
		end loop
		%Bullet disappears upon collision with wall or other tank
		Sprite.Hide (spriteBulletRed)
		%Displays winning screen if a tank is hit
		if ((tankGreenY - redBulletY) ** 2) + ((tankGreenX - redBulletX) ** 2) < 200 then
		    Sprite.Hide (spriteBulletRed)
		    Sprite.Hide (spriteBulletGreen)
		    Sprite.Hide (spriteTankGreenN)
		    Sprite.Hide (spriteTankGreenE)
		    Sprite.Hide (spriteTankGreenS)
		    Sprite.Hide (spriteTankGreenW)
		    Sprite.Hide (spriteTankRedN)
		    Sprite.Hide (spriteTankRedE)
		    Sprite.Hide (spriteTankRedS)
		    Sprite.Hide (spriteTankRedW)
		    cls
		    Pic.Draw (winOne, 0, 0, picCopy)
		    delay (100000)
		end if
		%Repeated for east
	    elsif dirRed = 2 then
		redBulletX := tankRedX + 17
		loop
		    Sprite.SetPosition (spriteBulletRed, redBulletX, tankRedY, true)
		    Sprite.Show (spriteBulletRed)
		    redBulletX := redBulletX + 1
		    delay (4)
		    exit when whatdotcolour (redBulletX, tankRedY) = 22 or ((tankGreenY - redBulletY) ** 2) + ((tankGreenX - redBulletX) ** 2) < 200
		end loop
		Sprite.Hide (spriteBulletRed)
		if ((tankGreenY - redBulletY) ** 2) + ((tankGreenX - redBulletX) ** 2) < 200 then
		    Sprite.Hide (spriteBulletRed)
		    Sprite.Hide (spriteBulletGreen)
		    Sprite.Hide (spriteTankGreenN)
		    Sprite.Hide (spriteTankGreenE)
		    Sprite.Hide (spriteTankGreenS)
		    Sprite.Hide (spriteTankGreenW)
		    Sprite.Hide (spriteTankRedN)
		    Sprite.Hide (spriteTankRedE)
		    Sprite.Hide (spriteTankRedS)
		    Sprite.Hide (spriteTankRedW)
		    cls
		    Pic.Draw (winOne, 0, 0, picCopy)
		    delay (100000)
		end if
		%Repeated for south
	    elsif dirRed = 3 then
		redBulletY := tankRedY - 17
		loop
		    Sprite.SetPosition (spriteBulletRed, tankRedX, redBulletY, true)
		    Sprite.Show (spriteBulletRed)
		    redBulletY := redBulletY - 1
		    delay (4)
		    exit when whatdotcolour (tankRedX, redBulletY) = 22 or ((tankGreenY - redBulletY) ** 2) + ((tankGreenX - redBulletX) ** 2) < 200
		end loop
		Sprite.Hide (spriteBulletRed)
		if ((tankGreenY - redBulletY) ** 2) + ((tankGreenX - redBulletX) ** 2) < 200 then
		    Sprite.Hide (spriteBulletRed)
		    Sprite.Hide (spriteBulletGreen)
		    Sprite.Hide (spriteTankGreenN)
		    Sprite.Hide (spriteTankGreenE)
		    Sprite.Hide (spriteTankGreenS)
		    Sprite.Hide (spriteTankGreenW)
		    Sprite.Hide (spriteTankRedN)
		    Sprite.Hide (spriteTankRedE)
		    Sprite.Hide (spriteTankRedS)
		    Sprite.Hide (spriteTankRedW)
		    cls
		    Pic.Draw (winOne, 0, 0, picCopy)
		    delay (100000)
		end if
		%Repeated for west
	    elsif dirRed = 4 then
		redBulletX := tankRedX - 17
		loop
		    Sprite.SetPosition (spriteBulletRed, redBulletX, tankRedY, true)
		    Sprite.Show (spriteBulletRed)
		    redBulletX := redBulletX - 1
		    delay (4)
		    exit when whatdotcolour (redBulletX, tankRedY) = 22 or ((tankGreenY - redBulletY) ** 2) + ((tankGreenX - redBulletX) ** 2) < 200
		end loop
		Sprite.Hide (spriteBulletRed)
		if ((tankGreenY - redBulletY) ** 2) + ((tankGreenX - redBulletX) ** 2) < 200 then
		    Sprite.Hide (spriteBulletRed)
		    Sprite.Hide (spriteBulletGreen)
		    Sprite.Hide (spriteTankGreenN)
		    Sprite.Hide (spriteTankGreenE)
		    Sprite.Hide (spriteTankGreenS)
		    Sprite.Hide (spriteTankGreenW)
		    Sprite.Hide (spriteTankRedN)
		    Sprite.Hide (spriteTankRedE)
		    Sprite.Hide (spriteTankRedS)
		    Sprite.Hide (spriteTankRedW)
		    cls
		    Pic.Draw (winOne, 0, 0, picCopy)
		    delay (100000)
		end if
	    end if
	end if
    end loop
end tankRedMove

%Process for the controls/actions of the green tank
process tankGreenMove
    var chars : array char of boolean
    loop
	Input.KeyDown (chars)
	if chars ('w') then
	    if whatdotcolour (tankGreenX, tankGreenY + 17) = 30 and whatdotcolour (tankGreenX - 10, tankGreenY + 17) = 30 and whatdotcolour (tankGreenX + 10, tankGreenY + 17) = 30
		    and whatdotcolour (tankGreenX - 5, tankGreenY + 17) = 30 and whatdotcolour (tankGreenX + 5, tankGreenY + 17) = 30 then
		Sprite.Show (spriteTankGreenN)
		Sprite.Hide (spriteTankGreenE)
		Sprite.Hide (spriteTankGreenS)
		Sprite.Hide (spriteTankGreenW)
		Sprite.SetPosition (spriteTankGreenN, tankGreenX, tankGreenY + 1, true)
		tankGreenY := tankGreenY + 1
		greenBulletY := tankGreenY
		dirGreen := 1
		delay (8)
	    end if
	elsif chars ('s') then
	    if whatdotcolour (tankGreenX, tankGreenY - 17) = 30 and whatdotcolour (tankGreenX - 10, tankGreenY - 17) = 30 and whatdotcolour (tankGreenX + 10, tankGreenY - 17) = 30
		    and whatdotcolour (tankGreenX - 5, tankGreenY - 17) = 30 and whatdotcolour (tankGreenX + 5, tankGreenY - 17) = 30 then
		Sprite.Show (spriteTankGreenS)
		Sprite.Hide (spriteTankGreenN)
		Sprite.Hide (spriteTankGreenE)
		Sprite.Hide (spriteTankGreenW)
		Sprite.SetPosition (spriteTankGreenS, tankGreenX, tankGreenY - 1, true)
		tankGreenY := tankGreenY - 1
		greenBulletY := tankGreenY
		dirGreen := 3
		delay (8)
	    end if
	elsif chars ('a') then
	    if whatdotcolour (tankGreenX - 17, tankGreenY) = 30 and whatdotcolour (tankGreenX - 17, tankGreenY - 10) = 30 and whatdotcolour (tankGreenX - 17, tankGreenY + 10) = 30
		    and whatdotcolour (tankGreenX - 17, tankGreenY + 5) = 30 and whatdotcolour (tankGreenX - 17, tankGreenY - 5) = 30 then
		Sprite.Show (spriteTankGreenW)
		Sprite.Hide (spriteTankGreenN)
		Sprite.Hide (spriteTankGreenE)
		Sprite.Hide (spriteTankGreenS)
		Sprite.SetPosition (spriteTankGreenW, tankGreenX - 1, tankGreenY, true)
		tankGreenX := tankGreenX - 1
		greenBulletX := tankGreenX
		dirGreen := 4
		delay (8)
	    end if
	elsif chars ('d') then
	    if whatdotcolour (tankGreenX + 17, tankGreenY) = 30 and whatdotcolour (tankGreenX + 17, tankGreenY - 10) = 30 and whatdotcolour (tankGreenX + 17, tankGreenY + 10) = 30
		    and whatdotcolour (tankGreenX + 17, tankGreenY + 5) = 30 and whatdotcolour (tankGreenX + 17, tankGreenY - 5) = 30 then
		Sprite.Show (spriteTankGreenE)
		Sprite.Hide (spriteTankGreenN)
		Sprite.Hide (spriteTankGreenS)
		Sprite.Hide (spriteTankGreenW)
		Sprite.SetPosition (spriteTankGreenE, tankGreenX + 1, tankGreenY, true)
		tankGreenX := tankGreenX + 1
		greenBulletX := tankGreenX
		dirGreen := 2
		delay (8)
	    end if
	end if
	if chars (' ') then
	    if dirGreen = 1 then
		greenBulletY := tankGreenY + 17
		loop
		    Sprite.SetPosition (spriteBulletGreen, tankGreenX, greenBulletY, true)
		    Sprite.Show (spriteBulletGreen)
		    greenBulletY := greenBulletY + 1
		    exit when whatdotcolour (tankGreenX, greenBulletY) = 22 or ((tankRedY - greenBulletY) ** 2) + ((tankRedX - greenBulletX) ** 2) < 200
		    delay (4)
		end loop
		Sprite.Hide (spriteBulletGreen)
		if ((tankRedY - greenBulletY) ** 2) + ((tankRedX - greenBulletX) ** 2) < 200 then
		    Sprite.Hide (spriteBulletGreen)
		    Sprite.Hide (spriteBulletRed)
		    Sprite.Hide (spriteTankRedN)
		    Sprite.Hide (spriteTankRedE)
		    Sprite.Hide (spriteTankRedS)
		    Sprite.Hide (spriteTankRedW)
		    Sprite.Hide (spriteTankGreenN)
		    Sprite.Hide (spriteTankGreenE)
		    Sprite.Hide (spriteTankGreenS)
		    Sprite.Hide (spriteTankGreenW)
		    cls
		    Pic.Draw (winTwo, 0, 0, picCopy)
		    delay (100000)
		end if
	    elsif dirGreen = 2 then
		greenBulletX := tankGreenX + 17
		loop
		    Sprite.SetPosition (spriteBulletGreen, greenBulletX, tankGreenY, true)
		    Sprite.Show (spriteBulletGreen)
		    greenBulletX := greenBulletX + 1
		    delay (4)
		    exit when whatdotcolour (greenBulletX, tankGreenY) = 22 or ((tankRedY - greenBulletY) ** 2) + ((tankRedX - greenBulletX) ** 2) < 200
		end loop
		Sprite.Hide (spriteBulletGreen)
		if ((tankRedY - greenBulletY) ** 2) + ((tankRedX - greenBulletX) ** 2) < 200 then
		    Sprite.Hide (spriteBulletGreen)
		    Sprite.Hide (spriteBulletRed)
		    Sprite.Hide (spriteTankRedN)
		    Sprite.Hide (spriteTankRedE)
		    Sprite.Hide (spriteTankRedS)
		    Sprite.Hide (spriteTankRedW)
		    Sprite.Hide (spriteTankGreenN)
		    Sprite.Hide (spriteTankGreenE)
		    Sprite.Hide (spriteTankGreenS)
		    Sprite.Hide (spriteTankGreenW)
		    cls
		    Pic.Draw (winTwo, 0, 0, picCopy)
		    delay (100000)
		end if
	    elsif dirGreen = 3 then
		greenBulletY := tankGreenY - 17
		loop
		    Sprite.SetPosition (spriteBulletGreen, tankGreenX, greenBulletY, true)
		    Sprite.Show (spriteBulletGreen)
		    greenBulletY := greenBulletY - 1
		    delay (4)
		    exit when whatdotcolour (tankGreenX, greenBulletY) = 22 or ((tankRedY - greenBulletY) ** 2) + ((tankRedX - greenBulletX) ** 2) < 200
		end loop
		Sprite.Hide (spriteBulletGreen)
		if ((tankRedY - greenBulletY) ** 2) + ((tankRedX - greenBulletX) ** 2) < 200 then
		    Sprite.Hide (spriteBulletGreen)
		    Sprite.Hide (spriteBulletRed)
		    Sprite.Hide (spriteTankRedN)
		    Sprite.Hide (spriteTankRedE)
		    Sprite.Hide (spriteTankRedS)
		    Sprite.Hide (spriteTankRedW)
		    Sprite.Hide (spriteTankGreenN)
		    Sprite.Hide (spriteTankGreenE)
		    Sprite.Hide (spriteTankGreenS)
		    Sprite.Hide (spriteTankGreenW)
		    cls
		    Pic.Draw (winTwo, 0, 0, picCopy)
		    delay (100000)
		end if
	    elsif dirGreen = 4 then
		greenBulletX := tankGreenX - 17
		loop
		    Sprite.SetPosition (spriteBulletGreen, greenBulletX, tankGreenY, true)
		    Sprite.Show (spriteBulletGreen)
		    greenBulletX := greenBulletX - 1
		    delay (4)
		    exit when whatdotcolour (greenBulletX, tankGreenY) = 22 or ((tankRedY - greenBulletY) ** 2) + ((tankRedX - greenBulletX) ** 2) < 200
		end loop
		Sprite.Hide (spriteBulletGreen)
		if ((tankRedY - greenBulletY) ** 2) + ((tankRedX - greenBulletX) ** 2) < 200 then
		    Sprite.Hide (spriteBulletGreen)
		    Sprite.Hide (spriteBulletRed)
		    Sprite.Hide (spriteTankRedN)
		    Sprite.Hide (spriteTankRedE)
		    Sprite.Hide (spriteTankRedS)
		    Sprite.Hide (spriteTankRedW)
		    Sprite.Hide (spriteTankGreenN)
		    Sprite.Hide (spriteTankGreenE)
		    Sprite.Hide (spriteTankGreenS)
		    Sprite.Hide (spriteTankGreenW)
		    cls
		    Pic.Draw (winTwo, 0, 0, picCopy)
		    delay (100000)
		end if
	    end if
	end if
    end loop
end tankGreenMove

%Displays the main menu
var menuPic : int
menuPic := Pic.FileNew ("menu.jpg")
menuPic := Pic.Scale (menuPic, 1000, 750)
Pic.Draw (menuPic, 0, 0, picMerge)
var x, y, notused1, notused2 : int
buttonwait ("down", x, y, notused1, notused2)

%Menu screen navigation
loop
    %Determines if "Play" is pressed
    if x > 395 and x < 605 and y > 385 and y < 485 then
	cls
	%Draws map
	Pic.Draw (background, 40, 50, picMerge)
	%Assigns tank images
	tankRedN := Pic.FileNew ("TankRedN.bmp")
	tankRedE := Pic.FileNew ("TankRedE.bmp")
	tankRedS := Pic.FileNew ("TankRedS.bmp")
	tankRedW := Pic.FileNew ("TankRedW.bmp")
	tankGreenN := Pic.FileNew ("TankGreenN.bmp")
	tankGreenE := Pic.FileNew ("TankGreenE.bmp")
	tankGreenS := Pic.FileNew ("TankGreenS.bmp")
	tankGreenW := Pic.FileNew ("TankGreenW.bmp")
	loop
	    %Generates random coordinates for the tank
	    randint (tankRedX, 175, 830)
	    randint (tankRedY, 210, 695)
	    randint (tankGreenX, 175, 830)
	    randint (tankGreenY, 210, 695)
	    %Creates the sprites of the tanks
	    spriteTankRedN := Sprite.New (tankRedN)
	    spriteTankRedE := Sprite.New (tankRedE)
	    spriteTankRedS := Sprite.New (tankRedS)
	    spriteTankRedW := Sprite.New (tankRedW)
	    spriteTankGreenN := Sprite.New (tankGreenN)
	    spriteTankGreenE := Sprite.New (tankGreenE)
	    spriteTankGreenS := Sprite.New (tankGreenS)
	    spriteTankGreenW := Sprite.New (tankGreenW)
	    %Positions the sprites
	    Sprite.SetPosition (spriteTankRedS, tankRedX, tankRedY, true)
	    Sprite.SetPosition (spriteTankGreenS, tankGreenX, tankGreenY, true)
	    %Sets the heights of the sprites
	    Sprite.SetHeight (spriteTankRedN, 2)
	    Sprite.SetHeight (spriteTankRedE, 2)
	    Sprite.SetHeight (spriteTankRedS, 2)
	    Sprite.SetHeight (spriteTankRedW, 2)
	    Sprite.SetHeight (spriteTankGreenN, 2)
	    Sprite.SetHeight (spriteTankGreenE, 2)
	    Sprite.SetHeight (spriteTankGreenS, 2)
	    Sprite.SetHeight (spriteTankGreenW, 2)
	    Sprite.SetHeight (spriteBulletRed, 1)
	    Sprite.SetHeight (spriteBulletGreen, 1)
	    %Makes sure the tanks are not generated on top of walls or outside the map, but only on the light grey areas
	    exit when whatdotcolour (tankRedX, tankRedY) = 30 and whatdotcolour (tankGreenX, tankGreenY) = 30 and whatdotcolour (tankRedX, tankRedY + 2) = 30 and
		whatdotcolour (tankGreenX, tankGreenY + 2) = 30 and whatdotcolour (tankRedX, tankRedY + 4) = 30 and whatdotcolour (tankGreenX, tankGreenY + 4) = 30
		and whatdotcolour (tankRedX, tankRedY + 17) = 30 and whatdotcolour (tankGreenX, tankGreenY + 17) = 30 and whatdotcolour (tankRedX, tankRedY + 6) = 30 and
		whatdotcolour (tankGreenX, tankGreenY + 6) = 30 and whatdotcolour (tankRedX, tankRedY + 8) = 30 and
		whatdotcolour (tankGreenX, tankGreenY + 8) = 30 and whatdotcolour (tankRedX, tankRedY + 10) = 30 and
		whatdotcolour (tankGreenX, tankGreenY + 10) = 30 and whatdotcolour (tankRedX, tankRedY + 12) = 30 and
		whatdotcolour (tankGreenX, tankGreenY + 12) = 30 and whatdotcolour (tankRedX, tankRedY + 14) = 30 and
		whatdotcolour (tankGreenX, tankGreenY + 14) = 30 and whatdotcolour (tankRedX, tankRedY - 2) = 30 and
		whatdotcolour (tankGreenX, tankGreenY - 2) = 30 and whatdotcolour (tankRedX, tankRedY + 4) = 30 and whatdotcolour (tankGreenX, tankGreenY - 4) = 30
		and whatdotcolour (tankRedX, tankRedY - 17) = 30 and whatdotcolour (tankGreenX, tankGreenY + 17) = 30 and whatdotcolour (tankRedX, tankRedY - 6) = 30 and
		whatdotcolour (tankGreenX, tankGreenY - 6) = 30 and whatdotcolour (tankRedX, tankRedY - 8) = 30 and
		whatdotcolour (tankGreenX, tankGreenY - 8) = 30 and whatdotcolour (tankRedX, tankRedY - 10) = 30 and
		whatdotcolour (tankGreenX, tankGreenY - 10) = 30 and whatdotcolour (tankRedX, tankRedY - 12) = 30 and
		whatdotcolour (tankGreenX, tankGreenY - 12) = 30 and whatdotcolour (tankRedX, tankRedY - 14) = 30 and
		whatdotcolour (tankGreenX, tankGreenY - 14) = 30
		and whatdotcolour (tankRedX + 5, tankRedY + 17) = 30 and whatdotcolour (tankGreenX + 5, tankGreenY + 17) = 30 and whatdotcolour (tankRedX + 10, tankRedY + 17) = 30 and
		whatdotcolour (tankGreenX + 10, tankGreenY + 17) = 30
		and whatdotcolour (tankRedX + 10, tankRedY + 12) = 30 and whatdotcolour (tankGreenX, tankGreenY + 12) = 30 and whatdotcolour (tankRedX + 10, tankRedY + 6) = 30 and
		whatdotcolour (tankGreenX, tankGreenY + 6) = 30
		and whatdotcolour (tankRedX + 10, tankRedY) = 30 and whatdotcolour (tankGreenX, tankGreenY) = 30 and whatdotcolour (tankRedX + 10, tankRedY - 6) = 30 and whatdotcolour (tankGreenX,
		tankGreenY - 6) = 30 and whatdotcolour (tankRedX + 10, tankRedY) = 30 and whatdotcolour (tankGreenX + 10, tankGreenY) = 30
		and whatdotcolour (tankRedX + 10, tankRedY - 12) = 30 and whatdotcolour (tankGreenX, tankGreenY - 12) = 30 and whatdotcolour (tankRedX + 10, tankRedY - 17) = 30 and
		whatdotcolour (tankGreenX, tankGreenY - 17) = 30
		and whatdotcolour (tankRedX + 5, tankRedY - 17) = 30 and whatdotcolour (tankGreenX + 5, tankGreenY - 17) = 30 and whatdotcolour (tankRedX, tankRedY - 17) = 30 and
		whatdotcolour (tankGreenX, tankGreenY - 17) = 30
		and whatdotcolour (tankRedX - 5, tankRedY - 17) = 30 and whatdotcolour (tankGreenX - 5, tankGreenY - 17) = 30 and whatdotcolour (tankRedX - 10, tankRedY - 17) = 30 and
		whatdotcolour (tankGreenX - 10, tankGreenY - 17) = 30
		and whatdotcolour (tankRedX - 10, tankRedY - 12) = 30 and whatdotcolour (tankGreenX - 10, tankGreenY - 12) = 30 and whatdotcolour (tankRedX - 10, tankRedY - 6) = 30 and
		whatdotcolour (tankGreenX - 10, tankGreenY - 6) = 30 and whatdotcolour (tankRedX - 10, tankRedY) = 30 and whatdotcolour (tankGreenX - 10, tankGreenY) = 30
		and whatdotcolour (tankRedX - 10, tankRedY) = 30 and whatdotcolour (tankGreenX - 10, tankGreenY) = 30 and whatdotcolour (tankRedX - 10, tankRedY + 6) = 30 and
		whatdotcolour (tankGreenX - 10, tankGreenY + 6) = 30
		and whatdotcolour (tankRedX - 10, tankRedY + 12) = 30 and whatdotcolour (tankGreenX - 10, tankGreenY + 12) = 30 and whatdotcolour (tankRedX - 10, tankRedY + 17) = 30 and
		whatdotcolour (tankGreenX - 10, tankGreenY + 17) = 30
		and whatdotcolour (tankRedX - 5, tankRedY + 17) = 30 and whatdotcolour (tankGreenX - 5, tankGreenY + 17) = 30
	end loop
	%Displays the tanks
	Sprite.Show (spriteTankRedS)
	Sprite.Show (spriteTankGreenS)
	%Carries out the processes of the two tanks
	fork tankRedMove
	fork tankGreenMove
	%Exits when the tanks are properly created
	exit when x > 395 and x < 605 and y > 385 and y < 485
	%Determines if "Help" is pressed
    elsif x > 395 and x < 605 and y > 260 and y < 360 then
	cls
	%Shows the instructions screen
	var wordPic : int
	wordPic := Pic.FileNew ("help.bmp")
	wordPic := Pic.Scale (wordPic, 1000, 750)
	Pic.Draw (wordPic, 0, 0, picMerge)
	buttonwait ("down", x, y, notused1, notused2)
	if x > 850 and x < 990 and y > 680 and y < 740 then
	    cls
	    %Shows the controls screen
	    var keysPic : int
	    keysPic := Pic.FileNew ("keys.bmp")
	    keysPic := Pic.Scale (keysPic, 1000, 750)
	    Pic.Draw (keysPic, 0, 0, picMerge)
	end if
	buttonwait ("down", x, y, notused1, notused2)
	if x > 10 and x < 100 and y > 700 and y < 740 then
	    cls
	    Pic.Draw (menuPic, 0, 0, picMerge)
	    buttonwait ("down", x, y, notused1, notused2)
	end if
    end if
end loop
