# upgradeable proxy with version control


add `version`,`historyImplementation` variables

```solidity
uint256 public override version = 1;
    
mapping(uint256 => address) override public historyImplementation;
```

add `rollback`,`backToVersion(uint256 toVersion)` methods.