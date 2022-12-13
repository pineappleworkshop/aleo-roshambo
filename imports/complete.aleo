program complete.aleo;

record complete:
    owner as address.private;
    gates as u64.private;
    challenger_selection as i64.private;
    acceptor_selection as i64.private;
    challenger as address.private;
    acceptor as address.private;
    winner as address.private;

function complete_challenge:
    input r0 as address.private; // acceptor
    input r1 as i64.private; // acceptor selection
    input r2 as i64.private; // challenger selection
    input r3 as address.private; // winner

    cast r0 0u64 r2 r1 self.caller r0 r3 into r4 as complete.record;
    cast self.caller 0u64 r2 r1 self.caller r0 r3 into r5 as complete.record;

    output r4 as complete.record;
    output r5 as complete.record;