import 'package:sounding_storage/database/database_sounding.dart';

import 'database_quality_doc.dart';

deleteDataQuality() {
  DatabaseQuality().deleteDeleteQualityOneWeekAgo();
  DatabaseQuality().deleteDeleteQualityOneWeekAgo1();
  DatabaseQuality().deleteDeleteQualityOneWeekAgo2();
  DatabaseQuality().deleteDeleteQualityOneWeekAgo3();
  DatabaseQuality().deleteDeleteQualityOneWeekAgo4();
  DatabaseQuality().deleteDeleteQualityOneWeekAgo5();
  DatabaseQuality().deleteDeleteQualityOneWeekAgo6();
}

deleteDataSounding() {
  DatabaseSounding().deleteDeleteSoundingOneWeekAgo();
  DatabaseSounding().deleteDeleteSoundingOneWeekAgo1();
  DatabaseSounding().deleteDeleteSoundingOneWeekAgo2();
  DatabaseSounding().deleteDeleteSoundingOneWeekAgo3();
  DatabaseSounding().deleteDeleteSoundingOneWeekAgo4();
  DatabaseSounding().deleteDeleteSoundingOneWeekAgo5();
  DatabaseSounding().deleteDeleteSoundingOneWeekAgo6();

}