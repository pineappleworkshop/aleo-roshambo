program accept.aleo;

record accept:
    owner as address.private;
    gates as u64.private;
    hashed_challenger_selection as field.private;
    acceptor_selection as i64.private;
    acceptor as address.private;

function accept_challenge:
    input r0 as address.private; // challenger address
    input r1 as field.private; // hashed challenger seed
    input r2 as i64.private; // acceptor seed

    cast r0 0u64 r1 r2 self.caller into r3 as accept.record;

    output r3 as accept.record;