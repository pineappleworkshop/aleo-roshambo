import challenge.aleo;
import accept.aleo;
import complete.aleo;

program roshambo.aleo;

// rock: 0
// paper: 1
// scizzors: 2 

// hashing helper function:
// hash(hash(selection)+hash(salt))
closure h:
    input r0 as u64; // selection
    input r1 as u64; // salt

    hash.psd8 r0 into r2;
    hash.psd8 r1 into r3;
    add r2 r3 into r4; 
    hash.psd8 r4 into r5;

    output r5 as field;

// ensure selection is valid
// 0 | 1 | 2
closure valid_selection:
    input r0 as u64;

    is.eq r0 0u64 into r1;
    is.eq r0 1u64 into r2;
    is.eq r0 2u64 into r3;
    ternary r1 r1 r2 into r4;
    ternary r4 r4 r3 into r5;

    output r5 as boolean;

function issue_challenge:
    input r0 as u64.private; // challenger's selection
    input r1 as u64.private; // challenger's salt, should be a random u64
    input r2 as address.private; // the acceptor's address

    call valid_selection r0 into r3;
    assert.eq r3 true;

    call h r0 r1 into r4;

    call challenge.aleo/issue_challenge r4 r2 into r5;

    output r5 as challenge.aleo/challenge.record;

function accept_challenge:
    input r0 as u64.private; // the acceptor's selection
    input r1 as challenge.aleo/challenge.record; // the issue record that was issued to the acceptor

    call valid_selection r0 into r2;
    assert.eq r2 true;

    call accept.aleo/accept_challenge r1.challenger r1.hashed_challenger_selection r0 into r3;

    output r3 as accept.aleo/accept.record;

// if (p1+1) % 3 == p2 => acceptor address
// else if p1 == p2 => nullable address (aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc)
// else => challenger
function complete_challenge:
    input r0 as u64.private; // original challenger's selection
    input r1 as u64.private; // original challenger's salt
    input r2 as accept.aleo/accept.record;

    // ensure that the challenger has not changed their selection
    call h r0 r1 into r3;
    assert.eq r3 r2.hashed_challenger_selection; 

    is.eq r0 r2.acceptor_selection into r4;
    ternary r4 aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc r2.owner into r5;

    add.w r0 1u64 into r6;
    mod r6 3u64 into r7;
    is.eq r7 r2.acceptor_selection into r8;
    ternary r8 r2.acceptor r5 into r9;

    call complete.aleo/complete_challenge r2.acceptor r2.acceptor_selection r0 r1 r9 into r10 r11;
    
    output r10 as complete.aleo/complete.record;
    output r11 as complete.aleo/complete.record;
