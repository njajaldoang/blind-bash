<div align="center">
  <img src="https://raw.githubusercontent.com/FajarKim/blind-bash/master/images/logo.png" alt="Blind Bash Logo" width="300"/>
  <h2>Blind Bash</h2>
  <p>Tools for obfuscated bash script 🛡️</p>
  <p><a href="https://github.com/FajarKim/blind-bash/issues/new?assignees=&labels=bug&projects=&template=bug_report.yml">Report Bug</a> · <a href="https://github.com/FajarKim/blind-bash/issues/new?assignees=&labels=enhancement&projects=&template=feature_request.yml">Request Feature</a> · <a href="https://github.com/FajarKim/blind-bash/discussions/new?category=q-a">Ask Question</a></p>
  <p><a href="/docs/README-ID.md">Indonesia</a> · <a href="/docs/README-KR.md">한국어</a> · <a href="/docs/README-FR.md">Français</a></p>
  <a href="https://github.com/FajarKim/blind-bash/releases"><img src="https://custom-icon-badges.demolab.com/github/v/tag/FajarKim/blind-bash?label=Version&labelColor=302d41&color=f2cdcd&logoColor=d9e0ee&logo=tag&style=for-the-badge" alt="Version"/></a>
  <a href="https://github.com/FajarKim/blind-bash/stargazers/"><img src="https://custom-icon-badges.demolab.com/github/stars/FajarKim/blind-bash?label=Stars&logo=star&labelColor=302d41&color=c9cbff&logoColor=d9e0ee&style=for-the-badge" alt="Stars"></a>
  <a href="https://github.com/FajarKim/blind-bash/network/members/"><img src="https://custom-icon-badges.demolab.com/github/forks/FajarKim/blind-bash?label=Forks&logo=fork&labelColor=302d41&color=b5e8e0&logoColor=d9e0ee&style=for-the-badge" alt="Forks"></a>
  <a href="https://github.com/FajarKim/blind-bash/issues"><img src="https://custom-icon-badges.demolab.com/github/issues/FajarKim/blind-bash?label=Issues&labelColor=302d41&color=f5a97f&logoColor=d9e0ee&logo=issue&style=for-the-badge" alt="Issues"/></a>
  <a href="https://github.com/FajarKim/blind-bash/pull"><img src="https://custom-icon-badges.demolab.com/github/issues-pr/FajarKim/blind-bash?&label=Pull%20Requests&labelColor=302d41&color=ddb6f2&logoColor=d9e0ee&logo=git-pull-request&style=for-the-badge" alt="PRs"/></a>
  <a href="https://github.com/FajarKim/blind-bash/archive/refs/heads/master.zip"><img src="https://custom-icon-badges.demolab.com/github/languages/code-size/FajarKim/blind-bash?label=Download&logo=download&labelColor=302d41&color=b7bdf8&logoColor=d9e0ee&style=for-the-badge" alt="Download .zip"></a>
</div>

# Description
Blind Bash is a versatile tool designed to obfuscate Bash scripts, enhancing script security by making them more challenging to decipher. The script incorporates random string and variable encryptions, making the obfuscation process more robust.

## Key Features
- **Randomization Techniques:** The tool incorporates random string and variable generation, enhancing the complexity of the obfuscated script and making it more resistant to reverse engineering.
- **User-Friendly:** Blind Bash is designed with simplicity in mind, providing users with an easy-to-understand interface for obfuscating Bash scripts.
- **Upgrade Check:** The tool includes a feature for checking updates, ensuring users have the latest version of Blind Bash and potentially benefiting from bug fixes or additional functionalities.
- **Enhanced Security:** Blind Bash significantly improves the security of Bash scripts by obfuscating your contents, making them less susceptible to unauthorized access or tampering.
- **Random Encryption:** The tool offers different obfuscation modes, allowing complexity of the obfuscated script and making it more resistant to reverse engineering.

> [!NOTE]
> The more number of lines in a file, the longer it will take to encrypt.

> [!WARNING]
> Blind Bash may not be compatible with some systems or devices.

# Installation Instructions
- ```shell
  pkg update -y && pkg upgrade -y
  ```
- ```shell
  pkg install coreutils xz-utils git -y
  ```
- ```shell
  git clone https://github.com/njajaldoang/blind-bash/
  ```
- ```shell
  cd blind-bash
  ```

Then, run the file `blind-bash.sh` to start encrypting the Bash file.
- ```shell
  bash blind-bash.sh --help
  ```

If you want to install it to the `$PATH` folder, just run the `install.sh` file located in the `tools` folder.
- ```shell
  tools/install.sh
  ```
  or
- ```shell
  cd tools && bash install.sh
  ```

If installed successfully, run the command:
- ```shell
  blind-bash --help
  ```

You can also use this method:
<table>
  <tr>
    <td><div align="center"><b>Method</b></div></td>
    <td><div align="center"><b>Command</b></div></td>
  </tr>
  <tr>
    <td><div align="center"><b>curl</b></div></td>
    <td>
      <div align="left">
        <pre class="language-shell"><code>bash -c "$(curl -fsSL https://raw.githubusercontent.com/njajaldoang/blind-bash/main/tools/install.sh)"</code></pre>
      </div>
    </td>
  </tr>
  <tr>
    <td><div align="center"><b>wget</b></div></td>
    <td>
      <div align="left">
        <pre class="language-shell"><code>bash -c "$(wget -qO- https://raw.githubusercontent.com/njajaldoang/blind-bash/main/tools/install.sh)"</code></pre>
      </div>
    </td>
  </tr>
  <tr>
    <td><div align="center"><b>fetch</b></div></td>
    <td>
      <div align="left">
        <pre class="language-shell"><code>bash -c "$(fetch -o - https://raw.githubusercontent.com/njajaldoang/blind-bash/main/tools/install.sh)"</code></pre>
      </div>
    </td>
  </tr>
</table>

As an alternative, you can first download the `install.sh` script and run it afterwards:
- ```shell
  wget https://raw.githubusercontent.com/njajaldoang/blind-bash/main/tools/install.sh
  ```
- ```shell
  bash install.sh
  ```

# Instructions for Use
This tool is programmed to be run with several commands. Supported commands:
<table>
  <tr>
    <td><div align="center"><b>Command</b></div></td>
    <td><div align="center"><b>Description</b></div></td>
  </tr>
  <tr>
    <td><div align="left"><code>-h</code> or <code>--help</code></div></td>
    <td><div align="left">Print help this tool.</div></td>
  </tr>
  <tr>
    <td><div align="left"><code>-v</code> or <code>--version</code></div></td>
    <td><div align="left">Output version information.</div></td>
  </tr>
  <tr>
    <td><div align="left"><code>-f</code> or <code>--file</code></div></td>
    <td><div align="left">Starting obfuscated files name.</div></td>
  </tr>
  <tr>
    <td><div align="left"><code>--upgrade</code></div></td>
    <td><div align="left">Upgrade version this tool.</div></td>
  </tr>
  <tr>
    <td><div align="left"><code>--uninstall</code></div></td>
    <td><div align="left">Uninstall this tool.</div></td>
  </tr>
</table>

How to run this tool:
#### Example 1
```shell
blind-bash.sh -f FILE
```
or
```shell
blind-bash.sh --file FILE
```
#### Example 2
If you want to encrypt more than 1 file at the same time, you can do that.
```shell
blind-bash.sh -f FILE1 FILE2 FILE3 etc...
```
or
```shell
blind-bash.sh --file FILE1 FILE2 FILE3 etc...
```

## License
Blind Bash is released under the AGPL-3.0 license, which grants the following permissions:
- Commercial use
- Modification
- Distribution
- Patent use
- Private use

For more convoluted language, see the [LICENSE](/LICENSE).

## Social Media and Contact
<div align="center">
  <a href="https://wa.me/6281383460513?text=Hi"><img src="https://raw.githubusercontent.com/FajarKim/FajarKim/master/images/icons/whatsapp-icon.svg" alt="WhatsApp"></a>
  <a href="https://t.me/Crystalllz"><img src="https://raw.githubusercontent.com/FajarKim/FajarKim/master/images/icons/telegram-icon.svg" alt="Telegram"></a>
  <p>Follow my social media!</p>
</div>

# Donate
Love the project? Please consider donating to help it improve!
<div align="left">
  <a href="https://paypal.me/triadyrushartono/"><img src="https://img.shields.io/badge/PayPal-Donate-blue?labelColor=302d41&color=f4dbd6&logo=paypal&logoColor=d9e0ee&style=for-the-badge" alt="PayPal Donate"></a>
</div>


<div align="center">
  <img src="https://raw.githubusercontent.com/FajarKim/FajarKim/master/images/line.svg?sanitize=true"/>
</div>

<p align="center">Made with ❤️ and Shell</p>
<p align="center">Copyright © 2022-present Rangga Fajar Oktariansyah</p>
<div align="center">
  <a href="LICENSE"><img src="https://custom-icon-badges.demolab.com/github/license/FajarKim/blind-bash?label=License&labelColor=302d41&color=91d7e3&logo=law&logoColor=d9e0ee&style=for-the-badge" alt="License"></a>
</div>
