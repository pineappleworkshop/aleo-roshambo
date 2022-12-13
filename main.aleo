import challenge.aleo;
import accept.aleo;
import complete.aleo;

program roshambo.aleo;

// rock: 0
// paper: -1
// scizzors: 1 

// RULESET
//
// (p1 + 1) % 3 == p2 -> p2 wins
// p1 == p2 -> draw
// else -> p1 wins

function issue_challenge:
    input r0 as i64.private; // challenger's selection
    input r1 as i64.private; // challenger's salt, should be a random u64
    input r2 as address.private; // the acceptor's address

    // todo: assert that selection is valid
    // assert.eq r0 0i64 or 1i64 or 1i64;

    // append salt to selection
    add.w r0 r1 into r3;

    // convert selection into field
    hash.psd8 r3 into r4; 

    call challenge.aleo/issue_challenge r4 r2 into r5;

    output r5 as challenge.aleo/challenge.record;

function accept_challenge:
    input r0 as i64.private; // the acceptor's selection
    input r1 as challenge.aleo/challenge.record; // the issue record that was issued to the acceptor

    // assert that selection is valid
    // assert.eq r0 1i64 or 2i64 or 3i64;

    call accept.aleo/accept_challenge r1.challenger r1.hashed_challenger_selection r0 into r2;

    output r2 as accept.aleo/accept.record;

function complete_challenge:
    input r0 as i64.private; // original challenger's selection
    input r1 as i64.private; // original challenger's salt
    input r2 as accept.aleo/accept.record;

    // assert that selection is valid
    // assert.eq r0 1i64 or 2i64 or 3i64;

    // append salt to selection
    add.w r0 r1 into r3;
    // turn the challenger seed into a hashed field
    hash.psd8 r3 into r4; 
    // ensure that challenger's selection matches
    assert.eq r4 r2.hashed_challenger_selection; 

    // p2 wins
    add r0 1i64 into r5;
    div r5 3i64 into r6;
    is.eq r6 r2.acceptor_selection into r7;

    // draw
    is.eq r0 r2.acceptor_selection into r8;

    // p1 wins
    nor r7 r8 into r9;

    output r9 as boolean.public;


