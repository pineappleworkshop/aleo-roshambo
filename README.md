# roshambo.aleo

## Setup

```bash
# compile program
aleo build
```

## Players

roshambo requires 2 players.

```bash
# create player 1
aleo account new

output:

  Private Key  APrivateKey1zkpAHC6rNBp81k5jHmQUCPuaxdghJzyhHFNq97W2m86aQR7
     View Key  AViewKey1fsCNHSMyaygcyo8Zd7REQJk6j8UunigJdaxQhNRnychv
      Address  aleo1gz24cpclw8xu50kt6zer0h8e8fqt5hns5d0kyyw8a9r3fhm7qgzqsy25h8

# create player 2
aleo account new

output:

  Private Key  APrivateKey1zkp2HFXrg7oSAaHwnS4gQsgFZuvkWgUPoqmeiLSk2HrtTGu
     View Key  AViewKey1nU6Tcz7QcwK8YRZY9jmUPttMvqNitoxzQPiwz5Th4hap
      Address  aleo182l20qx8gns0j9339j2m4zqj4zqhqhvyrsp35hu5n956c2gyagpq3wycdk
```

## Issue a challenge

use player 1 creds

program.json:

```json
{
    "program": "roshambo.aleo",
    "version": "0.0.0",
    "description": "",
    "development": {
        "private_key": "APrivateKey1zkpAHC6rNBp81k5jHmQUCPuaxdghJzyhHFNq97W2m86aQR7",
        "address": "aleo1gz24cpclw8xu50kt6zer0h8e8fqt5hns5d0kyyw8a9r3fhm7qgzqsy25h8"
    },
    "license": "MIT"
}
```

issue a challenge to player 2. select "rock" and a random salt 12345.

rock: 0
paper: 1
scizzors: 2

```bash
$ aleo run issue_challenge 0u64 12345u64 aleo182l20qx8gns0j9339j2m4zqj4zqhqhvyrsp35hu5n956c2gyagpq3wycdk

output:

{
  owner: aleo182l20qx8gns0j9339j2m4zqj4zqhqhvyrsp35hu5n956c2gyagpq3wycdk.private,
  gates: 0u64.private,
  hashed_challenger_selection: 7055966458134493094026343887509056529495816437298370325219319591575818818703field.private,
  challenger: aleo1gz24cpclw8xu50kt6zer0h8e8fqt5hns5d0kyyw8a9r3fhm7qgzqsy25h8.private,
  _nonce: 2491407768399461807563092721446048157577602857669298247901163737707378276080group.public
}

```

## Accept a challenge

swap creds to player 2

program.json:

```json
{
    "program": "roshambo.aleo",
    "version": "0.0.0",
    "description": "",
    "development": {
        "private_key": "APrivateKey1zkp2HFXrg7oSAaHwnS4gQsgFZuvkWgUPoqmeiLSk2HrtTGu",
        "address": "aleo182l20qx8gns0j9339j2m4zqj4zqhqhvyrsp35hu5n956c2gyagpq3wycdk"
    },
    "license": "MIT"
}
```

accept player 1's challenge. select "scizzors" no salt needed this time.

```bash
$ aleo run accept_challenge 2u64 '{
  owner: aleo182l20qx8gns0j9339j2m4zqj4zqhqhvyrsp35hu5n956c2gyagpq3wycdk.private,
  gates: 0u64.private,
  hashed_challenger_selection: 7055966458134493094026343887509056529495816437298370325219319591575818818703field.private,
  challenger: aleo1f2gd4ehnzy5punf43zrpu4evatkzn0ds52wh703pmmd9p2wwycfqhqvu6f.private,
  _nonce: 670355575776335027940577382003618294715606559673973210856330688229880905616group.public
}'

output:

{
  owner: aleo1gz24cpclw8xu50kt6zer0h8e8fqt5hns5d0kyyw8a9r3fhm7qgzqsy25h8.private,
  gates: 0u64.private,
  hashed_challenger_selection: 7055966458134493094026343887509056529495816437298370325219319591575818818703field.private,
  acceptor_selection: 2u64.private,
  acceptor: aleo182l20qx8gns0j9339j2m4zqj4zqhqhvyrsp35hu5n956c2gyagpq3wycdk.private,
  _nonce: 5957110968261066590477069721108992895529080342490810381260112009184263826817group.public
}
```

## Complete a challenge

swap creds back to player 1

program.json:

```json
{
    "program": "roshambo.aleo",
    "version": "0.0.0",
    "description": "",
    "development": {
        "private_key": "APrivateKey1zkpAHC6rNBp81k5jHmQUCPuaxdghJzyhHFNq97W2m86aQR7",
        "address": "aleo1gz24cpclw8xu50kt6zer0h8e8fqt5hns5d0kyyw8a9r3fhm7qgzqsy25h8"
    },
    "license": "MIT"
}
```

complete challenge

```bash
$ aleo run complete_challenge 0u64 12345u64 '{
  owner: aleo1gz24cpclw8xu50kt6zer0h8e8fqt5hns5d0kyyw8a9r3fhm7qgzqsy25h8.private,
  gates: 0u64.private,
  hashed_challenger_selection: 7055966458134493094026343887509056529495816437298370325219319591575818818703field.private,
  acceptor_selection: 2u64.private,
  acceptor: aleo182l20qx8gns0j9339j2m4zqj4zqhqhvyrsp35hu5n956c2gyagpq3wycdk.private,
  _nonce: 5957110968261066590477069721108992895529080342490810381260112009184263826817group.public
}'
```

output:

{
  owner: aleo182l20qx8gns0j9339j2m4zqj4zqhqhvyrsp35hu5n956c2gyagpq3wycdk.private,
  gates: 0u64.private,
  challenger_selection: 0u64.private,
  challenger_salt: 12345u64.private,
  acceptor_selection: 2u64.private,
  challenger: aleo182l20qx8gns0j9339j2m4zqj4zqhqhvyrsp35hu5n956c2gyagpq3wycdk.private,
  acceptor: aleo182l20qx8gns0j9339j2m4zqj4zqhqhvyrsp35hu5n956c2gyagpq3wycdk.private,
  winner: aleo1gz24cpclw8xu50kt6zer0h8e8fqt5hns5d0kyyw8a9r3fhm7qgzqsy25h8.private,
  _nonce: 3421373572446961465532774689362055069804264037260714399257559702389719215010group.public
}
{
  owner: aleo182l20qx8gns0j9339j2m4zqj4zqhqhvyrsp35hu5n956c2gyagpq3wycdk.private,
  gates: 0u64.private,
  challenger_selection: 0u64.private,
  challenger_salt: 12345u64.private,
  acceptor_selection: 2u64.private,
  challenger: aleo182l20qx8gns0j9339j2m4zqj4zqhqhvyrsp35hu5n956c2gyagpq3wycdk.private,
  acceptor: aleo182l20qx8gns0j9339j2m4zqj4zqhqhvyrsp35hu5n956c2gyagpq3wycdk.private,
  winner: aleo1gz24cpclw8xu50kt6zer0h8e8fqt5hns5d0kyyw8a9r3fhm7qgzqsy25h8.private,
  _nonce: 2106844551343534463454978394080400576564181248754560116324693126161629756780group.public
}
```
