
CREATE TABLE app_user(
    id          text    PRIMARY KEY,
    username    text    UNIQUE
)
;

comment on table app_user is 'A table to record users of the application in order to assign ownership to e.g. intervention costong models';
comment on column app_user.username is 'Unique username to represent the user - could be an email address.';