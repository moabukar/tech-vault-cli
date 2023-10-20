# Tech-Vault CLI

![Tech-Vault CLI](./images/tech-vault.png)

Tech-Vault CLI is a command-line interface that fetches random technical interview questions from [Tech-Vault](https://github.com/moabukar/tech-vault). This tool is perfect for those who are looking to prepare for tech interviews and want a quick and easy way to get random questions.

## Table of Contents

- [Tech-Vault CLI](#tech-vault-cli)
  - [Table of Contents](#table-of-contents)
  - [Installation](#installation)
  - [Usage](#usage)
  - [Building from Source](#building-from-source)
  - [Contributing](#contributing)
  - [License](#license)

## Installation

To install the CLI tool, you can download the latest binary from the [releases page](https://github.com/moabukar/tech-vault-cli/releases) or install it via `go get`:

```bash
go get -u github.com/moabukar/tech-vault-cli/cmd/techvault
```

## Usage

After installation, you can fetch a random tech interview question by running:

```
techvault random
```

## Building from Source


```

Clone the Repository:

git clone https://github.com/moabukar/tech-vault-cli.git

cd tech-vault-cli


go install ./cmd/techvault

```

## Contributing

Feel free to open issues or pull requests to improve this tool. All contributions are welcome!

## License

This project is licensed under the Apache License - see the LICENSE file for details.
