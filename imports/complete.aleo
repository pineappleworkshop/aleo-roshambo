program complete.aleo;

record complete:
    owner as address.private;
    gates as u64.private;
    challenger_selection as u64.private;
    challenger_salt as u64.private;
    acceptor_selection as u64.private;
    challenger as address.private;
    acceptor as address.private;
    winner as address.private;

function complete_challenge:
    input r0 as address.private; // acceptor
    input r1 as u64.private; // acceptor selection
    input r2 as u64.private; // challenger selection
    input r3 as u64.private; // challenger salt
    input r4 as address.private; // winner

    cast r0 0u64 r2 r3 r1 self.caller r0 r4 into r5 as complete.record;
    cast self.caller 0u64 r2 r3 r1 self.caller r0 r4 into r6 as complete.record;

    output r5 as complete.record;
    output r6 as complete.record;
