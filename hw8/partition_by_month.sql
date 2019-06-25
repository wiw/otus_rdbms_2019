alter table CDR
    partition by hash( month(BILL_DATE) )
    partitions 12;
commit;