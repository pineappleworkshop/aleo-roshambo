program challenge.aleo;

// todo: update challenge "isAccepted"

record challenge:
    owner as address.private;
    gates as u64.private;
    hashed_challenger_selection as field.private;
    challenger as address.private;

function issue_challenge:
    input r0 as field.private; // the challenger's hashed selection
    input r1 as address.private; // the acceptor 

    cast r1 0u64 r0 self.caller into r2 as challenge.record;

    output r2 as challenge.record;
