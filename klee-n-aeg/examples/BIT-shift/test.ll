; ModuleID = 'test.bc'
source_filename = "test.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [16 x i8] c"r: %d, c: %d. \0A\00", align 1
@.str.1 = private unnamed_addr constant [30 x i8] c"moves: %lx. r: %d. c-1: %d. \0A\00", align 1
@.str.2 = private unnamed_addr constant [27 x i8] c"-------------------  %x, \0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !7 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i64, align 8
  store i32 0, i32* %1, align 4
  call void @llvm.dbg.declare(metadata i32* %2, metadata !11, metadata !DIExpression()), !dbg !12
  call void @llvm.dbg.declare(metadata i32* %3, metadata !13, metadata !DIExpression()), !dbg !14
  store i32 0, i32* %2, align 4, !dbg !15
  br label %5, !dbg !17

5:                                                ; preds = %498, %0
  %6 = load i32, i32* %2, align 4, !dbg !18
  %7 = icmp slt i32 %6, 8, !dbg !20
  br i1 %7, label %8, label %501, !dbg !21

8:                                                ; preds = %5
  store i32 0, i32* %3, align 4, !dbg !22
  br label %9, !dbg !24

9:                                                ; preds = %494, %8
  %10 = load i32, i32* %3, align 4, !dbg !25
  %11 = icmp slt i32 %10, 8, !dbg !27
  br i1 %11, label %12, label %497, !dbg !28

12:                                               ; preds = %9
  %13 = load i32, i32* %2, align 4, !dbg !29
  %14 = load i32, i32* %3, align 4, !dbg !31
  %15 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str, i64 0, i64 0), i32 %13, i32 %14), !dbg !32
  call void @llvm.dbg.declare(metadata i64* %4, metadata !33, metadata !DIExpression()), !dbg !39
  store i64 0, i64* %4, align 8, !dbg !39
  %16 = load i32, i32* %2, align 4, !dbg !40
  %17 = sub nsw i32 %16, 2, !dbg !40
  %18 = icmp sge i32 %17, 0, !dbg !40
  br i1 %18, label %19, label %40, !dbg !40

19:                                               ; preds = %12
  %20 = load i32, i32* %2, align 4, !dbg !40
  %21 = sub nsw i32 %20, 2, !dbg !40
  %22 = icmp sle i32 %21, 7, !dbg !40
  br i1 %22, label %23, label %40, !dbg !40

23:                                               ; preds = %19
  %24 = load i32, i32* %3, align 4, !dbg !40
  %25 = sub nsw i32 %24, 1, !dbg !40
  %26 = icmp sge i32 %25, 0, !dbg !40
  br i1 %26, label %27, label %40, !dbg !40

27:                                               ; preds = %23
  %28 = load i32, i32* %3, align 4, !dbg !40
  %29 = sub nsw i32 %28, 1, !dbg !40
  %30 = icmp sle i32 %29, 7, !dbg !40
  br i1 %30, label %31, label %40, !dbg !40

31:                                               ; preds = %27
  %32 = load i32, i32* %2, align 4, !dbg !40
  %33 = sub nsw i32 %32, 2, !dbg !40
  %34 = mul nsw i32 %33, 8, !dbg !40
  %35 = load i32, i32* %3, align 4, !dbg !40
  %36 = sub nsw i32 %35, 1, !dbg !40
  %37 = add nsw i32 %34, %36, !dbg !40
  %38 = zext i32 %37 to i64, !dbg !40
  %39 = shl i64 1, %38, !dbg !40
  br label %41, !dbg !40

40:                                               ; preds = %27, %23, %19, %12
  br label %41, !dbg !40

41:                                               ; preds = %40, %31
  %42 = phi i64 [ %39, %31 ], [ 0, %40 ], !dbg !40
  %43 = load i64, i64* %4, align 8, !dbg !41
  %44 = or i64 %43, %42, !dbg !41
  store i64 %44, i64* %4, align 8, !dbg !41
  %45 = load i32, i32* %2, align 4, !dbg !42
  %46 = sub nsw i32 %45, 1, !dbg !42
  %47 = icmp sge i32 %46, 0, !dbg !42
  br i1 %47, label %48, label %69, !dbg !42

48:                                               ; preds = %41
  %49 = load i32, i32* %2, align 4, !dbg !42
  %50 = sub nsw i32 %49, 1, !dbg !42
  %51 = icmp sle i32 %50, 7, !dbg !42
  br i1 %51, label %52, label %69, !dbg !42

52:                                               ; preds = %48
  %53 = load i32, i32* %3, align 4, !dbg !42
  %54 = sub nsw i32 %53, 2, !dbg !42
  %55 = icmp sge i32 %54, 0, !dbg !42
  br i1 %55, label %56, label %69, !dbg !42

56:                                               ; preds = %52
  %57 = load i32, i32* %3, align 4, !dbg !42
  %58 = sub nsw i32 %57, 2, !dbg !42
  %59 = icmp sle i32 %58, 7, !dbg !42
  br i1 %59, label %60, label %69, !dbg !42

60:                                               ; preds = %56
  %61 = load i32, i32* %2, align 4, !dbg !42
  %62 = sub nsw i32 %61, 1, !dbg !42
  %63 = mul nsw i32 %62, 8, !dbg !42
  %64 = load i32, i32* %3, align 4, !dbg !42
  %65 = sub nsw i32 %64, 2, !dbg !42
  %66 = add nsw i32 %63, %65, !dbg !42
  %67 = zext i32 %66 to i64, !dbg !42
  %68 = shl i64 1, %67, !dbg !42
  br label %70, !dbg !42

69:                                               ; preds = %56, %52, %48, %41
  br label %70, !dbg !42

70:                                               ; preds = %69, %60
  %71 = phi i64 [ %68, %60 ], [ 0, %69 ], !dbg !42
  %72 = load i64, i64* %4, align 8, !dbg !43
  %73 = or i64 %72, %71, !dbg !43
  store i64 %73, i64* %4, align 8, !dbg !43
  %74 = load i32, i32* %2, align 4, !dbg !44
  %75 = sub nsw i32 %74, 2, !dbg !44
  %76 = icmp sge i32 %75, 0, !dbg !44
  br i1 %76, label %77, label %98, !dbg !44

77:                                               ; preds = %70
  %78 = load i32, i32* %2, align 4, !dbg !44
  %79 = sub nsw i32 %78, 2, !dbg !44
  %80 = icmp sle i32 %79, 7, !dbg !44
  br i1 %80, label %81, label %98, !dbg !44

81:                                               ; preds = %77
  %82 = load i32, i32* %3, align 4, !dbg !44
  %83 = add nsw i32 %82, 1, !dbg !44
  %84 = icmp sge i32 %83, 0, !dbg !44
  br i1 %84, label %85, label %98, !dbg !44

85:                                               ; preds = %81
  %86 = load i32, i32* %3, align 4, !dbg !44
  %87 = add nsw i32 %86, 1, !dbg !44
  %88 = icmp sle i32 %87, 7, !dbg !44
  br i1 %88, label %89, label %98, !dbg !44

89:                                               ; preds = %85
  %90 = load i32, i32* %2, align 4, !dbg !44
  %91 = sub nsw i32 %90, 2, !dbg !44
  %92 = mul nsw i32 %91, 8, !dbg !44
  %93 = load i32, i32* %3, align 4, !dbg !44
  %94 = add nsw i32 %93, 1, !dbg !44
  %95 = add nsw i32 %92, %94, !dbg !44
  %96 = zext i32 %95 to i64, !dbg !44
  %97 = shl i64 1, %96, !dbg !44
  br label %99, !dbg !44

98:                                               ; preds = %85, %81, %77, %70
  br label %99, !dbg !44

99:                                               ; preds = %98, %89
  %100 = phi i64 [ %97, %89 ], [ 0, %98 ], !dbg !44
  %101 = load i64, i64* %4, align 8, !dbg !45
  %102 = or i64 %101, %100, !dbg !45
  store i64 %102, i64* %4, align 8, !dbg !45
  %103 = load i32, i32* %2, align 4, !dbg !46
  %104 = sub nsw i32 %103, 1, !dbg !46
  %105 = icmp sge i32 %104, 0, !dbg !46
  br i1 %105, label %106, label %127, !dbg !46

106:                                              ; preds = %99
  %107 = load i32, i32* %2, align 4, !dbg !46
  %108 = sub nsw i32 %107, 1, !dbg !46
  %109 = icmp sle i32 %108, 7, !dbg !46
  br i1 %109, label %110, label %127, !dbg !46

110:                                              ; preds = %106
  %111 = load i32, i32* %3, align 4, !dbg !46
  %112 = add nsw i32 %111, 2, !dbg !46
  %113 = icmp sge i32 %112, 0, !dbg !46
  br i1 %113, label %114, label %127, !dbg !46

114:                                              ; preds = %110
  %115 = load i32, i32* %3, align 4, !dbg !46
  %116 = add nsw i32 %115, 2, !dbg !46
  %117 = icmp sle i32 %116, 7, !dbg !46
  br i1 %117, label %118, label %127, !dbg !46

118:                                              ; preds = %114
  %119 = load i32, i32* %2, align 4, !dbg !46
  %120 = sub nsw i32 %119, 1, !dbg !46
  %121 = mul nsw i32 %120, 8, !dbg !46
  %122 = load i32, i32* %3, align 4, !dbg !46
  %123 = add nsw i32 %122, 2, !dbg !46
  %124 = add nsw i32 %121, %123, !dbg !46
  %125 = zext i32 %124 to i64, !dbg !46
  %126 = shl i64 1, %125, !dbg !46
  br label %128, !dbg !46

127:                                              ; preds = %114, %110, %106, %99
  br label %128, !dbg !46

128:                                              ; preds = %127, %118
  %129 = phi i64 [ %126, %118 ], [ 0, %127 ], !dbg !46
  %130 = load i64, i64* %4, align 8, !dbg !47
  %131 = or i64 %130, %129, !dbg !47
  store i64 %131, i64* %4, align 8, !dbg !47
  %132 = load i32, i32* %2, align 4, !dbg !48
  %133 = add nsw i32 %132, 2, !dbg !48
  %134 = icmp sge i32 %133, 0, !dbg !48
  br i1 %134, label %135, label %156, !dbg !48

135:                                              ; preds = %128
  %136 = load i32, i32* %2, align 4, !dbg !48
  %137 = add nsw i32 %136, 2, !dbg !48
  %138 = icmp sle i32 %137, 7, !dbg !48
  br i1 %138, label %139, label %156, !dbg !48

139:                                              ; preds = %135
  %140 = load i32, i32* %3, align 4, !dbg !48
  %141 = sub nsw i32 %140, 1, !dbg !48
  %142 = icmp sge i32 %141, 0, !dbg !48
  br i1 %142, label %143, label %156, !dbg !48

143:                                              ; preds = %139
  %144 = load i32, i32* %3, align 4, !dbg !48
  %145 = sub nsw i32 %144, 1, !dbg !48
  %146 = icmp sle i32 %145, 7, !dbg !48
  br i1 %146, label %147, label %156, !dbg !48

147:                                              ; preds = %143
  %148 = load i32, i32* %2, align 4, !dbg !48
  %149 = add nsw i32 %148, 2, !dbg !48
  %150 = mul nsw i32 %149, 8, !dbg !48
  %151 = load i32, i32* %3, align 4, !dbg !48
  %152 = sub nsw i32 %151, 1, !dbg !48
  %153 = add nsw i32 %150, %152, !dbg !48
  %154 = zext i32 %153 to i64, !dbg !48
  %155 = shl i64 1, %154, !dbg !48
  br label %157, !dbg !48

156:                                              ; preds = %143, %139, %135, %128
  br label %157, !dbg !48

157:                                              ; preds = %156, %147
  %158 = phi i64 [ %155, %147 ], [ 0, %156 ], !dbg !48
  %159 = load i64, i64* %4, align 8, !dbg !49
  %160 = or i64 %159, %158, !dbg !49
  store i64 %160, i64* %4, align 8, !dbg !49
  %161 = load i32, i32* %2, align 4, !dbg !50
  %162 = add nsw i32 %161, 1, !dbg !50
  %163 = icmp sge i32 %162, 0, !dbg !50
  br i1 %163, label %164, label %185, !dbg !50

164:                                              ; preds = %157
  %165 = load i32, i32* %2, align 4, !dbg !50
  %166 = add nsw i32 %165, 1, !dbg !50
  %167 = icmp sle i32 %166, 7, !dbg !50
  br i1 %167, label %168, label %185, !dbg !50

168:                                              ; preds = %164
  %169 = load i32, i32* %3, align 4, !dbg !50
  %170 = sub nsw i32 %169, 2, !dbg !50
  %171 = icmp sge i32 %170, 0, !dbg !50
  br i1 %171, label %172, label %185, !dbg !50

172:                                              ; preds = %168
  %173 = load i32, i32* %3, align 4, !dbg !50
  %174 = sub nsw i32 %173, 2, !dbg !50
  %175 = icmp sle i32 %174, 7, !dbg !50
  br i1 %175, label %176, label %185, !dbg !50

176:                                              ; preds = %172
  %177 = load i32, i32* %2, align 4, !dbg !50
  %178 = add nsw i32 %177, 1, !dbg !50
  %179 = mul nsw i32 %178, 8, !dbg !50
  %180 = load i32, i32* %3, align 4, !dbg !50
  %181 = sub nsw i32 %180, 2, !dbg !50
  %182 = add nsw i32 %179, %181, !dbg !50
  %183 = zext i32 %182 to i64, !dbg !50
  %184 = shl i64 1, %183, !dbg !50
  br label %186, !dbg !50

185:                                              ; preds = %172, %168, %164, %157
  br label %186, !dbg !50

186:                                              ; preds = %185, %176
  %187 = phi i64 [ %184, %176 ], [ 0, %185 ], !dbg !50
  %188 = load i64, i64* %4, align 8, !dbg !51
  %189 = or i64 %188, %187, !dbg !51
  store i64 %189, i64* %4, align 8, !dbg !51
  %190 = load i32, i32* %2, align 4, !dbg !52
  %191 = add nsw i32 %190, 2, !dbg !52
  %192 = icmp sge i32 %191, 0, !dbg !52
  br i1 %192, label %193, label %214, !dbg !52

193:                                              ; preds = %186
  %194 = load i32, i32* %2, align 4, !dbg !52
  %195 = add nsw i32 %194, 2, !dbg !52
  %196 = icmp sle i32 %195, 7, !dbg !52
  br i1 %196, label %197, label %214, !dbg !52

197:                                              ; preds = %193
  %198 = load i32, i32* %3, align 4, !dbg !52
  %199 = add nsw i32 %198, 1, !dbg !52
  %200 = icmp sge i32 %199, 0, !dbg !52
  br i1 %200, label %201, label %214, !dbg !52

201:                                              ; preds = %197
  %202 = load i32, i32* %3, align 4, !dbg !52
  %203 = add nsw i32 %202, 1, !dbg !52
  %204 = icmp sle i32 %203, 7, !dbg !52
  br i1 %204, label %205, label %214, !dbg !52

205:                                              ; preds = %201
  %206 = load i32, i32* %2, align 4, !dbg !52
  %207 = add nsw i32 %206, 2, !dbg !52
  %208 = mul nsw i32 %207, 8, !dbg !52
  %209 = load i32, i32* %3, align 4, !dbg !52
  %210 = add nsw i32 %209, 1, !dbg !52
  %211 = add nsw i32 %208, %210, !dbg !52
  %212 = zext i32 %211 to i64, !dbg !52
  %213 = shl i64 1, %212, !dbg !52
  br label %215, !dbg !52

214:                                              ; preds = %201, %197, %193, %186
  br label %215, !dbg !52

215:                                              ; preds = %214, %205
  %216 = phi i64 [ %213, %205 ], [ 0, %214 ], !dbg !52
  %217 = load i64, i64* %4, align 8, !dbg !53
  %218 = or i64 %217, %216, !dbg !53
  store i64 %218, i64* %4, align 8, !dbg !53
  %219 = load i32, i32* %2, align 4, !dbg !54
  %220 = add nsw i32 %219, 1, !dbg !54
  %221 = icmp sge i32 %220, 0, !dbg !54
  br i1 %221, label %222, label %243, !dbg !54

222:                                              ; preds = %215
  %223 = load i32, i32* %2, align 4, !dbg !54
  %224 = add nsw i32 %223, 1, !dbg !54
  %225 = icmp sle i32 %224, 7, !dbg !54
  br i1 %225, label %226, label %243, !dbg !54

226:                                              ; preds = %222
  %227 = load i32, i32* %3, align 4, !dbg !54
  %228 = add nsw i32 %227, 2, !dbg !54
  %229 = icmp sge i32 %228, 0, !dbg !54
  br i1 %229, label %230, label %243, !dbg !54

230:                                              ; preds = %226
  %231 = load i32, i32* %3, align 4, !dbg !54
  %232 = add nsw i32 %231, 2, !dbg !54
  %233 = icmp sle i32 %232, 7, !dbg !54
  br i1 %233, label %234, label %243, !dbg !54

234:                                              ; preds = %230
  %235 = load i32, i32* %2, align 4, !dbg !54
  %236 = add nsw i32 %235, 1, !dbg !54
  %237 = mul nsw i32 %236, 8, !dbg !54
  %238 = load i32, i32* %3, align 4, !dbg !54
  %239 = add nsw i32 %238, 2, !dbg !54
  %240 = add nsw i32 %237, %239, !dbg !54
  %241 = zext i32 %240 to i64, !dbg !54
  %242 = shl i64 1, %241, !dbg !54
  br label %244, !dbg !54

243:                                              ; preds = %230, %226, %222, %215
  br label %244, !dbg !54

244:                                              ; preds = %243, %234
  %245 = phi i64 [ %242, %234 ], [ 0, %243 ], !dbg !54
  %246 = load i64, i64* %4, align 8, !dbg !55
  %247 = or i64 %246, %245, !dbg !55
  store i64 %247, i64* %4, align 8, !dbg !55
  store i64 0, i64* %4, align 8, !dbg !56
  %248 = load i32, i32* %2, align 4, !dbg !57
  %249 = sub nsw i32 %248, 1, !dbg !57
  %250 = icmp sge i32 %249, 0, !dbg !57
  br i1 %250, label %251, label %272, !dbg !57

251:                                              ; preds = %244
  %252 = load i32, i32* %2, align 4, !dbg !57
  %253 = sub nsw i32 %252, 1, !dbg !57
  %254 = icmp sle i32 %253, 7, !dbg !57
  br i1 %254, label %255, label %272, !dbg !57

255:                                              ; preds = %251
  %256 = load i32, i32* %3, align 4, !dbg !57
  %257 = sub nsw i32 %256, 1, !dbg !57
  %258 = icmp sge i32 %257, 0, !dbg !57
  br i1 %258, label %259, label %272, !dbg !57

259:                                              ; preds = %255
  %260 = load i32, i32* %3, align 4, !dbg !57
  %261 = sub nsw i32 %260, 1, !dbg !57
  %262 = icmp sle i32 %261, 7, !dbg !57
  br i1 %262, label %263, label %272, !dbg !57

263:                                              ; preds = %259
  %264 = load i32, i32* %2, align 4, !dbg !57
  %265 = sub nsw i32 %264, 1, !dbg !57
  %266 = mul nsw i32 %265, 8, !dbg !57
  %267 = load i32, i32* %3, align 4, !dbg !57
  %268 = sub nsw i32 %267, 1, !dbg !57
  %269 = add nsw i32 %266, %268, !dbg !57
  %270 = zext i32 %269 to i64, !dbg !57
  %271 = shl i64 1, %270, !dbg !57
  br label %273, !dbg !57

272:                                              ; preds = %259, %255, %251, %244
  br label %273, !dbg !57

273:                                              ; preds = %272, %263
  %274 = phi i64 [ %271, %263 ], [ 0, %272 ], !dbg !57
  %275 = load i64, i64* %4, align 8, !dbg !58
  %276 = or i64 %275, %274, !dbg !58
  store i64 %276, i64* %4, align 8, !dbg !58
  %277 = load i32, i32* %2, align 4, !dbg !59
  %278 = sub nsw i32 %277, 1, !dbg !59
  %279 = icmp sge i32 %278, 0, !dbg !59
  br i1 %279, label %280, label %298, !dbg !59

280:                                              ; preds = %273
  %281 = load i32, i32* %2, align 4, !dbg !59
  %282 = sub nsw i32 %281, 1, !dbg !59
  %283 = icmp sle i32 %282, 7, !dbg !59
  br i1 %283, label %284, label %298, !dbg !59

284:                                              ; preds = %280
  %285 = load i32, i32* %3, align 4, !dbg !59
  %286 = icmp sge i32 %285, 0, !dbg !59
  br i1 %286, label %287, label %298, !dbg !59

287:                                              ; preds = %284
  %288 = load i32, i32* %3, align 4, !dbg !59
  %289 = icmp sle i32 %288, 7, !dbg !59
  br i1 %289, label %290, label %298, !dbg !59

290:                                              ; preds = %287
  %291 = load i32, i32* %2, align 4, !dbg !59
  %292 = sub nsw i32 %291, 1, !dbg !59
  %293 = mul nsw i32 %292, 8, !dbg !59
  %294 = load i32, i32* %3, align 4, !dbg !59
  %295 = add nsw i32 %293, %294, !dbg !59
  %296 = zext i32 %295 to i64, !dbg !59
  %297 = shl i64 1, %296, !dbg !59
  br label %299, !dbg !59

298:                                              ; preds = %287, %284, %280, %273
  br label %299, !dbg !59

299:                                              ; preds = %298, %290
  %300 = phi i64 [ %297, %290 ], [ 0, %298 ], !dbg !59
  %301 = load i64, i64* %4, align 8, !dbg !60
  %302 = or i64 %301, %300, !dbg !60
  store i64 %302, i64* %4, align 8, !dbg !60
  %303 = load i32, i32* %2, align 4, !dbg !61
  %304 = sub nsw i32 %303, 1, !dbg !61
  %305 = icmp sge i32 %304, 0, !dbg !61
  br i1 %305, label %306, label %327, !dbg !61

306:                                              ; preds = %299
  %307 = load i32, i32* %2, align 4, !dbg !61
  %308 = sub nsw i32 %307, 1, !dbg !61
  %309 = icmp sle i32 %308, 7, !dbg !61
  br i1 %309, label %310, label %327, !dbg !61

310:                                              ; preds = %306
  %311 = load i32, i32* %3, align 4, !dbg !61
  %312 = add nsw i32 %311, 1, !dbg !61
  %313 = icmp sge i32 %312, 0, !dbg !61
  br i1 %313, label %314, label %327, !dbg !61

314:                                              ; preds = %310
  %315 = load i32, i32* %3, align 4, !dbg !61
  %316 = add nsw i32 %315, 1, !dbg !61
  %317 = icmp sle i32 %316, 7, !dbg !61
  br i1 %317, label %318, label %327, !dbg !61

318:                                              ; preds = %314
  %319 = load i32, i32* %2, align 4, !dbg !61
  %320 = sub nsw i32 %319, 1, !dbg !61
  %321 = mul nsw i32 %320, 8, !dbg !61
  %322 = load i32, i32* %3, align 4, !dbg !61
  %323 = add nsw i32 %322, 1, !dbg !61
  %324 = add nsw i32 %321, %323, !dbg !61
  %325 = zext i32 %324 to i64, !dbg !61
  %326 = shl i64 1, %325, !dbg !61
  br label %328, !dbg !61

327:                                              ; preds = %314, %310, %306, %299
  br label %328, !dbg !61

328:                                              ; preds = %327, %318
  %329 = phi i64 [ %326, %318 ], [ 0, %327 ], !dbg !61
  %330 = load i64, i64* %4, align 8, !dbg !62
  %331 = or i64 %330, %329, !dbg !62
  store i64 %331, i64* %4, align 8, !dbg !62
  %332 = load i64, i64* %4, align 8, !dbg !63
  %333 = load i32, i32* %2, align 4, !dbg !64
  %334 = load i32, i32* %3, align 4, !dbg !65
  %335 = sub nsw i32 %334, 1, !dbg !66
  %336 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([30 x i8], [30 x i8]* @.str.1, i64 0, i64 0), i64 %332, i32 %333, i32 %335), !dbg !67
  %337 = load i32, i32* %2, align 4, !dbg !68
  %338 = icmp sge i32 %337, 0, !dbg !70
  br i1 %338, label %339, label %357, !dbg !71

339:                                              ; preds = %328
  %340 = load i32, i32* %2, align 4, !dbg !72
  %341 = icmp sle i32 %340, 7, !dbg !73
  br i1 %341, label %342, label %357, !dbg !74

342:                                              ; preds = %339
  %343 = load i32, i32* %3, align 4, !dbg !75
  %344 = sub nsw i32 %343, 1, !dbg !76
  %345 = icmp sge i32 %344, 0, !dbg !77
  br i1 %345, label %346, label %357, !dbg !78

346:                                              ; preds = %342
  %347 = load i32, i32* %3, align 4, !dbg !79
  %348 = sub nsw i32 %347, 1, !dbg !80
  %349 = icmp sle i32 %348, 7, !dbg !81
  br i1 %349, label %350, label %357, !dbg !82

350:                                              ; preds = %346
  %351 = load i32, i32* %2, align 4, !dbg !83
  %352 = mul nsw i32 %351, 8, !dbg !84
  %353 = load i32, i32* %3, align 4, !dbg !85
  %354 = sub nsw i32 %353, 1, !dbg !86
  %355 = add nsw i32 %352, %354, !dbg !87
  %356 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([27 x i8], [27 x i8]* @.str.2, i64 0, i64 0), i32 %355), !dbg !88
  br label %357, !dbg !88

357:                                              ; preds = %350, %346, %342, %339, %328
  %358 = load i32, i32* %2, align 4, !dbg !89
  %359 = icmp sge i32 %358, 0, !dbg !89
  br i1 %359, label %360, label %379, !dbg !89

360:                                              ; preds = %357
  %361 = load i32, i32* %2, align 4, !dbg !89
  %362 = icmp sle i32 %361, 7, !dbg !89
  br i1 %362, label %363, label %379, !dbg !89

363:                                              ; preds = %360
  %364 = load i32, i32* %3, align 4, !dbg !89
  %365 = sub nsw i32 %364, 1, !dbg !89
  %366 = icmp sge i32 %365, 0, !dbg !89
  br i1 %366, label %367, label %379, !dbg !89

367:                                              ; preds = %363
  %368 = load i32, i32* %3, align 4, !dbg !89
  %369 = sub nsw i32 %368, 1, !dbg !89
  %370 = icmp sle i32 %369, 7, !dbg !89
  br i1 %370, label %371, label %379, !dbg !89

371:                                              ; preds = %367
  %372 = load i32, i32* %2, align 4, !dbg !89
  %373 = mul nsw i32 %372, 8, !dbg !89
  %374 = load i32, i32* %3, align 4, !dbg !89
  %375 = sub nsw i32 %374, 1, !dbg !89
  %376 = add nsw i32 %373, %375, !dbg !89
  %377 = zext i32 %376 to i64, !dbg !89
  %378 = shl i64 1, %377, !dbg !89
  br label %380, !dbg !89

379:                                              ; preds = %367, %363, %360, %357
  br label %380, !dbg !89

380:                                              ; preds = %379, %371
  %381 = phi i64 [ %378, %371 ], [ 0, %379 ], !dbg !89
  %382 = load i64, i64* %4, align 8, !dbg !90
  %383 = or i64 %382, %381, !dbg !90
  store i64 %383, i64* %4, align 8, !dbg !90
  %384 = load i32, i32* %2, align 4, !dbg !91
  %385 = icmp sge i32 %384, 0, !dbg !91
  br i1 %385, label %386, label %405, !dbg !91

386:                                              ; preds = %380
  %387 = load i32, i32* %2, align 4, !dbg !91
  %388 = icmp sle i32 %387, 7, !dbg !91
  br i1 %388, label %389, label %405, !dbg !91

389:                                              ; preds = %386
  %390 = load i32, i32* %3, align 4, !dbg !91
  %391 = add nsw i32 %390, 1, !dbg !91
  %392 = icmp sge i32 %391, 0, !dbg !91
  br i1 %392, label %393, label %405, !dbg !91

393:                                              ; preds = %389
  %394 = load i32, i32* %3, align 4, !dbg !91
  %395 = add nsw i32 %394, 1, !dbg !91
  %396 = icmp sle i32 %395, 7, !dbg !91
  br i1 %396, label %397, label %405, !dbg !91

397:                                              ; preds = %393
  %398 = load i32, i32* %2, align 4, !dbg !91
  %399 = mul nsw i32 %398, 8, !dbg !91
  %400 = load i32, i32* %3, align 4, !dbg !91
  %401 = add nsw i32 %400, 1, !dbg !91
  %402 = add nsw i32 %399, %401, !dbg !91
  %403 = zext i32 %402 to i64, !dbg !91
  %404 = shl i64 1, %403, !dbg !91
  br label %406, !dbg !91

405:                                              ; preds = %393, %389, %386, %380
  br label %406, !dbg !91

406:                                              ; preds = %405, %397
  %407 = phi i64 [ %404, %397 ], [ 0, %405 ], !dbg !91
  %408 = load i64, i64* %4, align 8, !dbg !92
  %409 = or i64 %408, %407, !dbg !92
  store i64 %409, i64* %4, align 8, !dbg !92
  %410 = load i32, i32* %2, align 4, !dbg !93
  %411 = add nsw i32 %410, 1, !dbg !93
  %412 = icmp sge i32 %411, 0, !dbg !93
  br i1 %412, label %413, label %434, !dbg !93

413:                                              ; preds = %406
  %414 = load i32, i32* %2, align 4, !dbg !93
  %415 = add nsw i32 %414, 1, !dbg !93
  %416 = icmp sle i32 %415, 7, !dbg !93
  br i1 %416, label %417, label %434, !dbg !93

417:                                              ; preds = %413
  %418 = load i32, i32* %3, align 4, !dbg !93
  %419 = sub nsw i32 %418, 1, !dbg !93
  %420 = icmp sge i32 %419, 0, !dbg !93
  br i1 %420, label %421, label %434, !dbg !93

421:                                              ; preds = %417
  %422 = load i32, i32* %3, align 4, !dbg !93
  %423 = sub nsw i32 %422, 1, !dbg !93
  %424 = icmp sle i32 %423, 7, !dbg !93
  br i1 %424, label %425, label %434, !dbg !93

425:                                              ; preds = %421
  %426 = load i32, i32* %2, align 4, !dbg !93
  %427 = add nsw i32 %426, 1, !dbg !93
  %428 = mul nsw i32 %427, 8, !dbg !93
  %429 = load i32, i32* %3, align 4, !dbg !93
  %430 = sub nsw i32 %429, 1, !dbg !93
  %431 = add nsw i32 %428, %430, !dbg !93
  %432 = zext i32 %431 to i64, !dbg !93
  %433 = shl i64 1, %432, !dbg !93
  br label %435, !dbg !93

434:                                              ; preds = %421, %417, %413, %406
  br label %435, !dbg !93

435:                                              ; preds = %434, %425
  %436 = phi i64 [ %433, %425 ], [ 0, %434 ], !dbg !93
  %437 = load i64, i64* %4, align 8, !dbg !94
  %438 = or i64 %437, %436, !dbg !94
  store i64 %438, i64* %4, align 8, !dbg !94
  %439 = load i32, i32* %2, align 4, !dbg !95
  %440 = add nsw i32 %439, 1, !dbg !95
  %441 = icmp sge i32 %440, 0, !dbg !95
  br i1 %441, label %442, label %460, !dbg !95

442:                                              ; preds = %435
  %443 = load i32, i32* %2, align 4, !dbg !95
  %444 = add nsw i32 %443, 1, !dbg !95
  %445 = icmp sle i32 %444, 7, !dbg !95
  br i1 %445, label %446, label %460, !dbg !95

446:                                              ; preds = %442
  %447 = load i32, i32* %3, align 4, !dbg !95
  %448 = icmp sge i32 %447, 0, !dbg !95
  br i1 %448, label %449, label %460, !dbg !95

449:                                              ; preds = %446
  %450 = load i32, i32* %3, align 4, !dbg !95
  %451 = icmp sle i32 %450, 7, !dbg !95
  br i1 %451, label %452, label %460, !dbg !95

452:                                              ; preds = %449
  %453 = load i32, i32* %2, align 4, !dbg !95
  %454 = add nsw i32 %453, 1, !dbg !95
  %455 = mul nsw i32 %454, 8, !dbg !95
  %456 = load i32, i32* %3, align 4, !dbg !95
  %457 = add nsw i32 %455, %456, !dbg !95
  %458 = zext i32 %457 to i64, !dbg !95
  %459 = shl i64 1, %458, !dbg !95
  br label %461, !dbg !95

460:                                              ; preds = %449, %446, %442, %435
  br label %461, !dbg !95

461:                                              ; preds = %460, %452
  %462 = phi i64 [ %459, %452 ], [ 0, %460 ], !dbg !95
  %463 = load i64, i64* %4, align 8, !dbg !96
  %464 = or i64 %463, %462, !dbg !96
  store i64 %464, i64* %4, align 8, !dbg !96
  %465 = load i32, i32* %2, align 4, !dbg !97
  %466 = add nsw i32 %465, 1, !dbg !97
  %467 = icmp sge i32 %466, 0, !dbg !97
  br i1 %467, label %468, label %489, !dbg !97

468:                                              ; preds = %461
  %469 = load i32, i32* %2, align 4, !dbg !97
  %470 = add nsw i32 %469, 1, !dbg !97
  %471 = icmp sle i32 %470, 7, !dbg !97
  br i1 %471, label %472, label %489, !dbg !97

472:                                              ; preds = %468
  %473 = load i32, i32* %3, align 4, !dbg !97
  %474 = add nsw i32 %473, 1, !dbg !97
  %475 = icmp sge i32 %474, 0, !dbg !97
  br i1 %475, label %476, label %489, !dbg !97

476:                                              ; preds = %472
  %477 = load i32, i32* %3, align 4, !dbg !97
  %478 = add nsw i32 %477, 1, !dbg !97
  %479 = icmp sle i32 %478, 7, !dbg !97
  br i1 %479, label %480, label %489, !dbg !97

480:                                              ; preds = %476
  %481 = load i32, i32* %2, align 4, !dbg !97
  %482 = add nsw i32 %481, 1, !dbg !97
  %483 = mul nsw i32 %482, 8, !dbg !97
  %484 = load i32, i32* %3, align 4, !dbg !97
  %485 = add nsw i32 %484, 1, !dbg !97
  %486 = add nsw i32 %483, %485, !dbg !97
  %487 = zext i32 %486 to i64, !dbg !97
  %488 = shl i64 1, %487, !dbg !97
  br label %490, !dbg !97

489:                                              ; preds = %476, %472, %468, %461
  br label %490, !dbg !97

490:                                              ; preds = %489, %480
  %491 = phi i64 [ %488, %480 ], [ 0, %489 ], !dbg !97
  %492 = load i64, i64* %4, align 8, !dbg !98
  %493 = or i64 %492, %491, !dbg !98
  store i64 %493, i64* %4, align 8, !dbg !98
  br label %494, !dbg !99

494:                                              ; preds = %490
  %495 = load i32, i32* %3, align 4, !dbg !100
  %496 = add nsw i32 %495, 1, !dbg !100
  store i32 %496, i32* %3, align 4, !dbg !100
  br label %9, !dbg !101, !llvm.loop !102

497:                                              ; preds = %9
  br label %498, !dbg !103

498:                                              ; preds = %497
  %499 = load i32, i32* %2, align 4, !dbg !104
  %500 = add nsw i32 %499, 1, !dbg !104
  store i32 %500, i32* %2, align 4, !dbg !104
  br label %5, !dbg !105, !llvm.loop !106

501:                                              ; preds = %5
  %502 = load i32, i32* %1, align 4, !dbg !108
  ret i32 %502, !dbg !108
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare dso_local i32 @printf(i8*, ...) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 9.0.0-2~ubuntu18.04.2 (tags/RELEASE_900/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, nameTableKind: None)
!1 = !DIFile(filename: "test.c", directory: "/home/beverly/Documents/klee/examples/BIT-shift")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 9.0.0-2~ubuntu18.04.2 (tags/RELEASE_900/final)"}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 7, type: !8, scopeLine: 8, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "r", scope: !7, file: !1, line: 9, type: !10)
!12 = !DILocation(line: 9, column: 9, scope: !7)
!13 = !DILocalVariable(name: "c", scope: !7, file: !1, line: 9, type: !10)
!14 = !DILocation(line: 9, column: 12, scope: !7)
!15 = !DILocation(line: 18, column: 12, scope: !16)
!16 = distinct !DILexicalBlock(scope: !7, file: !1, line: 18, column: 5)
!17 = !DILocation(line: 18, column: 10, scope: !16)
!18 = !DILocation(line: 18, column: 17, scope: !19)
!19 = distinct !DILexicalBlock(scope: !16, file: !1, line: 18, column: 5)
!20 = !DILocation(line: 18, column: 19, scope: !19)
!21 = !DILocation(line: 18, column: 5, scope: !16)
!22 = !DILocation(line: 19, column: 12, scope: !23)
!23 = distinct !DILexicalBlock(scope: !19, file: !1, line: 19, column: 5)
!24 = !DILocation(line: 19, column: 10, scope: !23)
!25 = !DILocation(line: 19, column: 17, scope: !26)
!26 = distinct !DILexicalBlock(scope: !23, file: !1, line: 19, column: 5)
!27 = !DILocation(line: 19, column: 19, scope: !26)
!28 = !DILocation(line: 19, column: 5, scope: !23)
!29 = !DILocation(line: 21, column: 37, scope: !30)
!30 = distinct !DILexicalBlock(scope: !26, file: !1, line: 20, column: 5)
!31 = !DILocation(line: 21, column: 40, scope: !30)
!32 = !DILocation(line: 21, column: 9, scope: !30)
!33 = !DILocalVariable(name: "moves", scope: !30, file: !1, line: 27, type: !34)
!34 = !DIDerivedType(tag: DW_TAG_typedef, name: "int64_t", file: !35, line: 27, baseType: !36)
!35 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/stdint-intn.h", directory: "")
!36 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int64_t", file: !37, line: 43, baseType: !38)
!37 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types.h", directory: "")
!38 = !DIBasicType(name: "long int", size: 64, encoding: DW_ATE_signed)
!39 = !DILocation(line: 27, column: 17, scope: !30)
!40 = !DILocation(line: 29, column: 18, scope: !30)
!41 = !DILocation(line: 29, column: 15, scope: !30)
!42 = !DILocation(line: 30, column: 18, scope: !30)
!43 = !DILocation(line: 30, column: 15, scope: !30)
!44 = !DILocation(line: 31, column: 18, scope: !30)
!45 = !DILocation(line: 31, column: 15, scope: !30)
!46 = !DILocation(line: 32, column: 18, scope: !30)
!47 = !DILocation(line: 32, column: 15, scope: !30)
!48 = !DILocation(line: 33, column: 18, scope: !30)
!49 = !DILocation(line: 33, column: 15, scope: !30)
!50 = !DILocation(line: 34, column: 18, scope: !30)
!51 = !DILocation(line: 34, column: 15, scope: !30)
!52 = !DILocation(line: 35, column: 18, scope: !30)
!53 = !DILocation(line: 35, column: 15, scope: !30)
!54 = !DILocation(line: 36, column: 18, scope: !30)
!55 = !DILocation(line: 36, column: 15, scope: !30)
!56 = !DILocation(line: 40, column: 15, scope: !30)
!57 = !DILocation(line: 41, column: 18, scope: !30)
!58 = !DILocation(line: 41, column: 15, scope: !30)
!59 = !DILocation(line: 42, column: 18, scope: !30)
!60 = !DILocation(line: 42, column: 15, scope: !30)
!61 = !DILocation(line: 43, column: 18, scope: !30)
!62 = !DILocation(line: 43, column: 15, scope: !30)
!63 = !DILocation(line: 45, column: 51, scope: !30)
!64 = !DILocation(line: 45, column: 58, scope: !30)
!65 = !DILocation(line: 45, column: 61, scope: !30)
!66 = !DILocation(line: 45, column: 62, scope: !30)
!67 = !DILocation(line: 45, column: 9, scope: !30)
!68 = !DILocation(line: 46, column: 13, scope: !69)
!69 = distinct !DILexicalBlock(scope: !30, file: !1, line: 46, column: 13)
!70 = !DILocation(line: 46, column: 15, scope: !69)
!71 = !DILocation(line: 46, column: 20, scope: !69)
!72 = !DILocation(line: 46, column: 23, scope: !69)
!73 = !DILocation(line: 46, column: 25, scope: !69)
!74 = !DILocation(line: 46, column: 30, scope: !69)
!75 = !DILocation(line: 46, column: 34, scope: !69)
!76 = !DILocation(line: 46, column: 35, scope: !69)
!77 = !DILocation(line: 46, column: 39, scope: !69)
!78 = !DILocation(line: 46, column: 44, scope: !69)
!79 = !DILocation(line: 46, column: 48, scope: !69)
!80 = !DILocation(line: 46, column: 49, scope: !69)
!81 = !DILocation(line: 46, column: 53, scope: !69)
!82 = !DILocation(line: 46, column: 13, scope: !30)
!83 = !DILocation(line: 47, column: 54, scope: !69)
!84 = !DILocation(line: 47, column: 57, scope: !69)
!85 = !DILocation(line: 47, column: 64, scope: !69)
!86 = !DILocation(line: 47, column: 65, scope: !69)
!87 = !DILocation(line: 47, column: 61, scope: !69)
!88 = !DILocation(line: 47, column: 13, scope: !69)
!89 = !DILocation(line: 49, column: 18, scope: !30)
!90 = !DILocation(line: 49, column: 15, scope: !30)
!91 = !DILocation(line: 50, column: 18, scope: !30)
!92 = !DILocation(line: 50, column: 15, scope: !30)
!93 = !DILocation(line: 51, column: 18, scope: !30)
!94 = !DILocation(line: 51, column: 15, scope: !30)
!95 = !DILocation(line: 52, column: 18, scope: !30)
!96 = !DILocation(line: 52, column: 15, scope: !30)
!97 = !DILocation(line: 53, column: 18, scope: !30)
!98 = !DILocation(line: 53, column: 15, scope: !30)
!99 = !DILocation(line: 56, column: 5, scope: !30)
!100 = !DILocation(line: 19, column: 25, scope: !26)
!101 = !DILocation(line: 19, column: 5, scope: !26)
!102 = distinct !{!102, !28, !103}
!103 = !DILocation(line: 56, column: 5, scope: !23)
!104 = !DILocation(line: 18, column: 25, scope: !19)
!105 = !DILocation(line: 18, column: 5, scope: !19)
!106 = distinct !{!106, !21, !107}
!107 = !DILocation(line: 56, column: 5, scope: !16)
!108 = !DILocation(line: 58, column: 1, scope: !7)
