const _contributionData = """
DateTime,Spydon,Erick,Luan,Pasha,Wolfenrain,DevKage,Feroult,Renan,Munsterlander,Japalekhin,Comunity
2017-10,0,0,14,0,0,0,0,0,0,0,0
2017-11,0,0,14,0,0,0,25,0,0,0,0
2017-12,0,0,27,0,0,0,7,0,0,0,0
2018-01,0,0,7,0,0,0,0,0,0,0,0
2018-02,0,0,0,0,0,0,0,0,0,0,0
2018-03,0,0,13,0,0,0,0,0,0,0,0
2018-04,0,0,14,0,0,0,0,0,0,0,0
2018-05,0,0,10,0,0,0,0,0,0,0,0
2018-06,0,0,1,0,0,0,0,0,0,0,0
2018-07,0,2,9,0,0,0,3,0,0,0,0
2018-08,0,0,8,0,0,0,0,0,0,0,0
2018-09,0,0,9,0,0,0,0,0,0,0,2
2018-10,0,0,2,0,0,0,0,0,0,0,0
2018-11,0,0,0,0,0,0,0,0,0,0,0
2018-12,0,2,19,0,0,0,11,0,0,0,0
2019-01,0,6,24,0,0,0,0,0,0,0,0
2019-02,0,3,5,0,0,0,3,0,0,0,0
2019-03,1,14,6,0,0,0,10,3,0,0,0
2019-04,0,4,12,0,0,0,0,1,0,0,0
2019-05,0,12,3,0,0,0,0,0,0,0,1
2019-06,0,16,8,0,0,0,0,0,0,0,2
2019-07,6,33,12,0,0,0,0,0,0,0,2
2019-08,0,9,0,0,0,0,0,0,0,0,6
2019-09,3,4,8,0,0,0,0,1,0,20,2
2019-10,0,11,18,0,0,0,0,0,0,0,3
2019-11,0,7,2,0,0,0,0,0,0,0,10
2019-12,0,2,4,0,3,0,0,0,0,0,6
2020-01,0,26,8,0,0,0,0,0,0,0,1
2020-02,0,3,3,0,0,0,0,0,0,0,2
2020-03,4,28,4,0,0,0,0,3,0,0,8
2020-04,13,36,10,0,0,0,0,0,0,0,12
2020-05,102,57,11,0,0,0,0,0,0,0,17
2020-06,22,35,17,0,0,0,0,0,0,0,0
2020-07,0,9,0,0,0,0,0,0,0,0,0
2020-08,0,10,15,0,4,0,0,3,0,0,3
2020-09,56,20,23,0,1,0,0,1,0,0,0
2020-10,67,17,14,0,0,0,0,2,0,0,3
2020-11,70,15,9,0,0,0,0,3,0,0,7
2020-12,20,23,8,0,1,0,0,3,0,0,3
2021-01,9,12,2,0,6,0,0,2,0,0,8
2021-02,8,4,12,0,4,0,0,0,0,0,2
2021-03,13,14,15,0,11,0,0,0,0,0,5
2021-04,6,11,11,0,0,0,0,2,0,0,0
2021-05,25,7,18,0,2,0,0,0,0,0,2
2021-06,14,3,1,0,6,0,0,3,0,0,1
2021-07,19,3,7,0,0,0,0,1,0,0,0
2021-08,9,4,3,7,4,0,0,1,0,0,2
2021-09,16,5,17,4,3,0,0,1,0,0,1
2021-10,30,15,18,12,3,0,0,0,0,0,5
2021-11,42,10,13,12,1,0,0,3,0,0,2
2021-12,43,5,6,27,2,5,0,1,0,0,4
2022-01,12,4,0,8,0,2,0,0,0,0,6
2022-02,4,12,1,12,1,0,0,0,2,0,6
2022-03,20,17,1,16,3,0,0,0,2,0,5
2022-04,13,1,0,15,2,0,0,0,1,0,12
2022-05,23,4,0,27,3,1,0,2,1,0,6
2022-06,16,6,7,18,3,0,0,1,0,0,6
2022-07,6,1,0,10,1,2,0,0,0,0,4
2022-08,11,1,1,7,0,1,0,1,0,0,3
2022-09,16,1,0,4,0,7,0,0,0,0,12
2022-10,19,0,2,16,1,5,0,1,12,0,56
2022-11,14,1,0,18,0,1,0,1,1,0,4
2022-12,2,0,1,11,0,0,0,0,1,0,0
2023-01,12,2,3,22,4,0,0,0,2,0,5
2023-02,12,0,10,8,2,0,0,1,0,0,11
2023-03,6,3,5,1,0,4,0,0,4,0,17
2023-04,25,2,3,0,0,8,0,0,0,0,14
2023-05,9,0,2,0,0,0,0,0,0,0,2
2023-06,2,5,0,0,1,1,0,0,0,0,4
2023-07,5,1,3,0,0,2,0,0,2,0,7
2023-08,12,0,19,0,0,1,0,0,3,0,4
2023-09,24,3,10,0,2,0,0,0,0,0,9
2023-10,16,5,6,0,1,2,0,0,0,0,11
2023-11,12,15,6,0,0,2,0,0,0,0,5
2023-12,27,10,1,0,0,3,0,0,0,0,9
2024-01,9,3,0,0,0,0,0,0,0,0,10
2024-02,20,0,3,0,1,4,0,1,0,0,8
2024-03,22,3,0,0,1,4,0,1,0,0,12
2024-04,7,0,5,0,0,1,0,1,0,0,4
2024-05,9,0,2,0,0,4,0,0,0,0,2
2024-06,6,0,8,0,0,0,0,0,0,0,2
2024-07,6,2,9,0,0,5,0,0,0,0,2
2024-08,5,6,4,0,0,0,0,0,0,0,0
2024-09,8,3,0,0,0,0,0,0,0,0,6
2024-10,5,3,1,0,0,0,0,0,0,0,1
""";

const _communityAuthorNames = [
  'Hwan-seok',
  'wenxiangjiang',
  'erf',
  'eukleshnin',
  'jtmcdole',
  'immadisairaj',
  'jithuraj',
  'ShwetaChauhan18',
  'dipakp2726',
  'kurtome',
  'imaNNeo',
  'duck-dev-go',
  'illiapoplawski',
  'Flavsditz',
  'YohanWadia',
  'nathanaelneveux',
  'eliasreis54',
  'anleac',
  'mattmyne',
  'shwetachauhan-simform',
  'pastordougdev',
  'brainwo',
  'idlehart',
  'denisgl7',
  'ayrotideysarkar',
  'bparrishMines',
  'lukepighetti',
  'lohnn',
  'unger1984',
  'filiph',
  'IanWadham',
  'github-actions[bot]',
  'aeb-dev',
  'sharyari',
  'adil192',
  'daisy1754',
  'abgutierrez',
  'tibotix',
  'lig',
  'mbiesiad',
  'renato-soares-dextra',
  'fa-fifi',
  'pedia',
  'YukiAttano',
  'cmc5788',
  'felangel',
  'trunghq3101',
  'woodsoul507',
  'huangyunict',
  'rivella50',
  'Anas35',
  'puneet-739',
  'Yayo-Arellano',
  'matthiasn',
  'aakash-pamnani',
  'markvideon',
  'alestiago',
  'xjyribro',
  'christopherfujino',
  'dinoandcat',
  'nmarafo',
  'lucasnlm',
  'chirag729',
  'ASGAlex',
  'allisonryan0002',
  'rubberbird',
  'Gustl22',
  'brumbrumm',
  'av',
  'jessp01',
  'leeflix',
  'Skyost',
  'HarrisonQi',
  'quentin7b',
  'JosephCarrington',
  'dependabot[bot]',
  'oloshe',
  'AlexV525',
  'KurtLa',
  'victoreronmosele',
  'fbcouch',
  'l1553k',
  'domesticmouse',
  'NashIlli',
  'elibdev',
  'tyemy',
  'erickzanardo-dx',
  'projectitis',
  'tozu',
  'lfraker',
];

final class TopAuthorEntity {
  final String name;
  final List<int> commits;
  final int minCommits;
  final int maxCommits;
  final double avgCommits;

  TopAuthorEntity(
    this.name,
    this.commits,
    this.minCommits,
    this.maxCommits,
    this.avgCommits,
  );
}

final class MultipleAuthorsEntity {
  final List<String> names;
  final List<int> commits;

  final int minCommits;
  final int maxCommits;
  final double avgCommits;

  MultipleAuthorsEntity(
    this.names,
    this.commits,
    this.minCommits,
    this.maxCommits,
    this.avgCommits,
  );
}

class ContributionDataEntity {
  final List<String> dates;
  final List<TopAuthorEntity> topAuthors;
  final MultipleAuthorsEntity community;

  ContributionDataEntity(
    this.dates,
    this.topAuthors,
    this.community,
  );
}

ContributionDataEntity loadCommunityData() {
  final lines = _contributionData.split('\n');
  final dates = <String>[];
  final commitsData = <String, List<int>>{};

  final parts = lines[0].split(',');
  final names = parts.sublist(1).map((name) => name.trim()).toList();
  for (final name in names) {
    commitsData[name] = [];
  }

  for (int i = 1; i < lines.length; i++) {
    final line = lines[i];
    if (line.isEmpty) {
      continue;
    }
    final parts = line.split(',');
    dates.add(parts[0]);
    final commits = parts.sublist(1);
    for (int j = 0; j < commits.length; j++) {
      commitsData[names[j]]!.add(int.parse(commits[j]));
    }
  }
  final communityCommits = commitsData.remove(names.last)!;

  final topAuthors = commitsData.entries.map((entry) {
    final name = entry.key;
    final commits = entry.value;

    int? min;
    int? max;
    int sum = 0;
    int nonZeroCount = 0;
    for (final commit in commits) {
      if (commit == 0) {
        continue;
      }
      if (min == null || commit < min) {
        min = commit;
      }
      if (max == null || commit > max) {
        max = commit;
      }
      nonZeroCount++;
      sum += commit;
    }

    final avg = nonZeroCount == 0 ? 0.0 : sum / nonZeroCount;
    return TopAuthorEntity(name, commits, min!, max!, avg);
  }).toList();

  // sort by first commit index that is not 0
  topAuthors.sort((a, b) {
    final aIndex = a.commits.indexWhere((count) => count != 0);
    final bIndex = b.commits.indexWhere((count) => count != 0);
    return aIndex - bIndex;
  });

  int? communityMin;
  int? communityMax;
  int communitySum = 0;
  int communityNonZeroCount = 0;
  for (final commit in communityCommits) {
    if (commit == 0) {
      continue;
    }
    if (communityMin == null || commit < communityMin) {
      communityMin = commit;
    }
    if (communityMax == null || commit > communityMax) {
      communityMax = commit;
    }
    communityNonZeroCount++;
    communitySum += commit;
  }
  final communityAvg =
      communityNonZeroCount == 0 ? 0.0 : communitySum / communityNonZeroCount;

  return ContributionDataEntity(
    dates,
    topAuthors,
    MultipleAuthorsEntity(
      _communityAuthorNames,
      communityCommits,
      communityMin!,
      communityMax!,
      communityAvg,
    ),
  );
}
