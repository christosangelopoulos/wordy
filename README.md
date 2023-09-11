# Wordy

**Wordy** is a word spelling puzzle.

You have **6 guesses** to find out the **secret 5-letter word**.

![1.png](png/1.png)

---


![green.png](png/green.png)

If a letter appears **green**, that means that this letter **exists in the secret word, and is in the right position**.

![yellow.png](png/yellow.png)

If a letter appears **yellow**, that means that this letter **exists in the secret word, but is in NOT the right position**.

![red.png](png/red.png)

If a letter appears **red**, that means that this letter **does NOT appear in the secret word AT ALL**.

![3.png](png/3.png)

As mentioned above, there are **6 guesses** to find the secret word.


![4.png](png/4.png)


![6.png](png/6.png)

![8.png](png/8.png)
---

### Dependencies

* As mentioned above, this script is using the word list contained in `/usr/share/dict/words`.

  If your distro doesn't include this installed, you can install the respective package (`wordlist`, `words`) using the respective command (`apt`, `pacman`).

* **ADDITIONALLY**, if someone wishes to play the game using a different word list, they can do so, editing **LINE 17**of the `wordy.sh`

```
WORD_LIST="/usr/share/dict/words"

```
change to
```
WORD_LIST="/path/to/prefered/wordlist"

```


* Another, much less important dependency is [lolcat](https://github.com/busyloop/lolcat).

 `lolcat` helps show the *Statistics* in **color**, and therefore more fun.

 ![7.png](png/7.png)

 To install `lolcat`

  * Debian based:

    ```
    sudo apt install lolcat
    ```

 * Arch based:

    ```
    sudo pacman -S lolcat
    ```

 * CentOS, RHEL, Fedora:

    ```
    sudo dnf install lolcat
    ```


### Install

```
git clone https://gitlab.com/christosangel/wordy.git

cd wordy/

```

To run the script from any directory, it has to be made executable, and then copied to `$PATH`:

```

chmod +x wordy.sh

cp wordy.sh ~/.local/bin/

```

After that, the user must run this command in order to create the necessary directories and files:

```
mkdir ~/.cache/wordy/

cp statistics.txt wordy.png ~/.cache/wordy/

```

### Run

Just run:

```
wordy.sh
```
This TUI game was inspired by [wordle](https://www.nytimes.com/games/wordle/index.html)

There is another project that might interest you:

[https://gitlab.com/christosangel/wordle-solver](https://gitlab.com/christosangel/wordle-solver)


***Have fun!***
